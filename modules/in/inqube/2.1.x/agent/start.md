<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Index query builder for Elasticsearch (inqube) — agent index

A developer/base module that makes a Drupal **View** run against an **Elasticsearch** index through
`elasticsearch_helper`. It registers a Views **query plugin** (`elasticsearch_query`) that delegates
the query body to a pluggable **`ElasticsearchQueryBuilder`** plugin you write, plus a synthetic
`elasticsearch_result` Views base table with field handlers and an entity relationship. Package
`ElasticSearch Helper`. Depends on **`elasticsearch_helper`** (declared) and **`views`** (required in
practice). Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.1.7. **No routes, no
permissions, no config schema, no Drush, no admin UI** — extend it in custom code.

- **The query-builder plugin type, manager, annotation, base classes and helper trait (how to write a
  builder)** → [plugins/query-builder.md](plugins/query-builder.md)
- **The Views query plugin, `elasticsearch_result` base table, field handlers, entity relationship and
  debug subscriber (how to build a view)** → [views/query-and-handlers.md](views/query-and-handlers.md)

## What it actually is

- A **Views query plugin** `Elasticsearch` (id `elasticsearch_query`, `src/Plugin/views/query/Elasticsearch.php`),
  extending `QueryPluginBase`. It runs searches via `elasticsearch_helper.elasticsearch_client`
  (`Elastic\Elasticsearch\Client::search()`), turns hits into `ResultRow`s, and loads/hydrates entities.
- A **plugin type** `ElasticsearchQueryBuilder` (manager service `elasticsearch_query_builder.manager`,
  dir `src/Plugin/ElasticsearchQueryBuilder`, annotation `@ElasticsearchQueryBuilder`, interface
  `ElasticsearchQueryBuilderInterface`). Only one builder ships: `default` (returns `[]`). Real sites
  subclass `BaseRootQueryBuilder` / `BaseIndexRootQueryBuilder`.
- A **synthetic Views base table** `elasticsearch_result` declared in `inqube_views_data()`
  (`inqube.module`), with field/filter/relationship handlers.
- An **AJAX debug** event subscriber that logs the generated query to the browser console for admins.

## Provided plugins (from source)

- Views query: `elasticsearch_query` → `Plugin/views/query/Elasticsearch`.
- Views fields: `elasticsearch_source` (`field/Source`), `inqube_elasticsearch_source`
  (`field/InqubeSource` extends `Source`), `inqube_link_elasticsearch_source`
  (`field/InqubeLinkSource` extends `Source`), `elasticsearch_rendered_entity` (`field/RenderedEntity`).
- Views relationship: `entity_relationship` (`relationship/EntityRelationship` extends core `Standard`).
- Views filter: `keyword` uses core `string` filter; `elasticsearch_result` also declares a `source`
  field alias.
- Query-builder plugins: `default` (`Plugin/ElasticsearchQueryBuilder/DefaultElasticsearchQueryBuilder`).

## Services (`inqube.services.yml`)

- `elasticsearch_query_builder.manager` → `ElasticsearchQueryBuilderManager` (DefaultPluginManager;
  alter hook `inqube_elasticsearch_query_builder_info`, cache key `inqube_elasticsearch_query_builder_plugins`).
- `inqube.ajax_subscriber` → `EventSubscriber\AjaxResponseSubscriber` (tagged `event_subscriber`).

## Hooks & libraries

- `inqube_views_data()` — declares the `elasticsearch_result` base table and its handlers.
- Alter hook `inqube_elasticsearch_query_builder_info` (via the plugin manager `alterInfo`).
- Library `inqube/debug` (`js/debug.js`, depends `core/drupal`) — AJAX command `elasticsearch_query_debug`.

## Quick start

1. `drush en inqube` (pulls in `elasticsearch_helper`; configure a cluster there).
2. Write a builder plugin extending `BaseIndexRootQueryBuilder` — see
   [plugins/query-builder.md](plugins/query-builder.md).
3. Add a View on base table **"Elasticsearch result"**, open **Query settings**, select your builder,
   and (optionally) set the default entity relationship keys — see
   [views/query-and-handlers.md](views/query-and-handlers.md).
