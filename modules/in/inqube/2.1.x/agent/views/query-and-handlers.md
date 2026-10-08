<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views query plugin, base table & handlers (inqube)

How a view actually runs against Elasticsearch and how result rows are shaped. The query DSL itself
comes from an `ElasticsearchQueryBuilder` plugin — see
[../plugins/query-builder.md](../plugins/query-builder.md).

## The base table (`inqube_views_data()` in `inqube.module`)

Declares synthetic base table `elasticsearch_result` (group "Elasticsearch result"), with
`base.query_id = elasticsearch_query` (so the Inqube query plugin drives it). Handlers declared:
- `entity_relationship` — relationship id `entity_relationship`.
- `rendered_entity` — field id `elasticsearch_rendered_entity`.
- `source` — field id `elasticsearch_source` ("Source field").
- `keyword` — filter id `string` (core string filter; the field name a builder reads as a keyword).
- `inqueb_source` — field id `inqube_elasticsearch_source` ("Inqube source field").
- `inqube_link` — field id `inqube_link_elasticsearch_source` ("Inqube source link").

Add/alter these from another module with `hook_views_data_alter()` on `elasticsearch_result`.

## Query plugin: `Elasticsearch` (id `elasticsearch_query`)

`src/Plugin/views/query/Elasticsearch.php`, extends `QueryPluginBase`. Injected via `create()`:
`elasticsearch_helper.elasticsearch_client` (`Elastic\Elasticsearch\Client`), `entity_type.manager`,
`elasticsearch_query_builder.manager`.

- **Options** (`setOptionDefaults`): `query_builder` (''), `entity_relationship` = `{entity_type_key:'',
  entity_id_key:''}`. `buildOptionsForm()` renders a **select of all builder plugins** plus the default
  entity-relationship text fields (Query settings on the view).
- **`getQueryBuilder()`** — `createInstance($this->options['query_builder'])`, then `->init($view, $display, [])`;
  exceptions are logged to channel `inqube` and swallowed.
- **`query()`** — `array_merge(['size'=>getLimit(),'from'=>offset], $queryBuilder->buildQuery())`.
  `build()` stores it in `$view->build_info['query']` after the pager modifies limits.
- **`validate()`** — errors if a saved (non-new) view has no `query_builder` selected.
- **`executeQuery()`** — `$this->elasticsearchClient->search($query)`.
- **`execute()`** — runs the search; each `hits.hits` entry becomes a `ResultRow($hit)` (so `$row->_source`,
  `$row->_index`, etc. are available to field handlers); stores the full response on `$view->data` (for
  aggregations); wires the pager totals via `getTotalHits()` (reads `hits.total.value` on ES ≥ 7, else
  `hits.total`, using `ElasticsearchClientVersion::getMajorVersion()`); then `loadEntities()`. Errors are
  logged to `inqube` and yield an empty result (no exception surfaced to the page).
- **Placeholder no-ops** required by the Views contract: `ensureTable()`, `addField()` (returns field
  as-is), `addWhere()`, `addWhereExpression()`, `addGroupBy()`, `addRelationship()`, `placeholder()`;
  `addOrderBy()` records into `$this->orderby` (consumed by builders via `getSortValues()`).

### Entity hydration (`loadEntities` / relationships)

- `getEntityRelationships()` returns `['none' => options.entity_relationship] + <each entity_relationship
  handler's {entity_type_key, entity_id_key}>`.
- For each relationship, `getNestedValue()` reads the entity **type** and **id** out of each row using the
  configured keys (dot-notation into the hit; a leading `@` means a literal string, e.g. `@node`). Ids are
  grouped per type, `loadMultiple()`ed, and assigned: the `none` relationship sets `$row->_entity`, others
  set `$row->_relationship_entities[$id]`.
- Cache tags/contexts merge each loaded entity's, each relationship entity-type's list cache metadata, and
  the query builder's.

## Field handlers

- **`elasticsearch_source`** (`field/Source.php`) — option `source_field` (required). `render()` returns
  `getNestedValue($source_field, $row->_source)` (dot-separated nested key). Plain scalar output.
- **`inqube_elasticsearch_source`** (`field/InqubeSource.php`, extends `Source`) — adds options
  `sort_field`, `load_as_entity`, `link_to_entity`, `convert_to_link`. `render()`:
  - array value → an `item_list`; each item optionally loaded as a `load_as_entity` entity label (linked if
    `link_to_entity`), or converted to a link (`convert_to_link`), or plain `#markup`.
  - scalar → entity label (optionally linked) when `load_as_entity` + numeric; or a link; or `#markup`.
  - `convertValueToLink()` builds a `Url::fromUserInput('/'.$item)` for path-like values or `Url::fromUri()`
    when the value already has a scheme. `clickSort()` orders by `sort_field` or `source_field`.
- **`inqube_link_elasticsearch_source`** (`field/InqubeLinkSource.php`, extends `Source`) — options
  `sort_field` (default `title`), `trim_length` (10–200, default 50). Renders `_source` link data shaped as
  `{uri, title}` (single) or a list of them, via `Link::fromTextAndUrl()` with `Unicode::truncate()`.
  `clickSort()` orders by `source_field.sort_field`.
- **`elasticsearch_rendered_entity`** (`field/RenderedEntity.php`) — renders the row's matched Drupal
  entity in a view mode. Options: `view_mode` (YAML map of `entity_type:bundle` → view mode; validated with
  `Yaml::decode`), `set_result_on_entity` (store the hit on the entity as `$entity->search_result`).
  `render()` resolves the entity (respecting the field's relationship), gets a translation, builds it with
  the entity view builder, and **sets `#access` from `$entity->access('view', NULL, TRUE)`** — so entity
  view access is enforced. `getViewMode()` falls back to `default`.

## Relationship: `entity_relationship` (`relationship/EntityRelationship.php`)

Extends core `Standard`; forces `base field = NULL`, hides the "required" checkbox. Options
`entity_type_key` / `entity_id_key` are the `_source` keys used by the query plugin's `loadEntities()` to
hydrate `$row->_relationship_entities`. A leading `@` sets a fixed type (e.g. `@node`).

## AJAX query debug (`EventSubscriber/AjaxResponseSubscriber.php`)

On `KernelEvents::RESPONSE`, for a `ViewAjaxResponse` whose query handler is this `Elasticsearch` plugin,
it attaches library `inqube/debug` and an `ElasticsearchDebugCommand` carrying `build_info['query']`.
`js/debug.js` logs the query JSON to the browser console. **Gated**: only fires when the current user has
`administer views` **and** Views' `views.settings:ui.show.sql_query.enabled` is on — a developer aid, not a
public output.

## Build a view (operator steps)

1. Ensure `elasticsearch_helper` is configured and the target index exists/holds data.
2. Add a **View** on base table **"Elasticsearch result"**.
3. Edit **Query settings** → pick your **Elasticsearch query builder** plugin; optionally set the default
   **Entity type field** / **Entity ID field** (`_source` keys, or `@type` for a fixed type).
4. Add fields: `Source field` for raw values, `Rendered entity` for full teasers (add an **Entity
   relationship** first, pointing at the type/id keys), `Inqube source field`/`Inqube source link` for
   entity-label/link output.
5. Add the `keyword` filter (exposed) for full-text; your builder maps its `realField` via
   `$keywordFilters`/`$keywordFields`.
