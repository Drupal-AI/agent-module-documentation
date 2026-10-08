<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, computed payload, GraphQL & delete protection

Declared in `entity_field_fetch.services.yml`.

## `entity_field_fetch.fetcher` — `Service/Fetcher.php`

The core engine. Injects `entity.repository`, `entity_type.manager`, `renderer`, `logger.factory`,
`messenger`. Stateful: `setFieldDefinition()` calls `nuke()` (clears state) then `init()`; most
methods first assert `haveDefinition()`.

- **Target resolution** from field settings: `getTargetEntityType()` (returns `paragraph` when a
  paragraph id is set, else the `target_entity_type` setting), `getTargetId()`
  (`target_entity_id`, or the paragraph id), `getTargetFieldName()` (`field_to_fetch`, or NULL for
  a paragraph target), `getParagraphId()` (`target_paragraph_uuid`).
- **`loadPrimaryEntity()`** — `entityTypeManager->getStorage($type)->load($id)`.
  **`loadParagraph()`** — `entityRepository->loadEntityByUuid('paragraph', …)` if the id is a valid
  UUID (backward compat), else `getCanonical('paragraph', …)`.
- **`getEntityData()`** is the payload builder. For a paragraph target it takes the paragraph's
  `toArray()`; otherwise it extracts just `entity_data[$target_field]`. It then runs
  `processFields()`.
- **`processFields()`** (depth-guarded, `$level <= 10`) walks each field and applies:
  - `addProcessedToTextFormatFields()` — for values with `value`+`format` (WYSIWYG-like), renders
    the field via `$source->get($field)->get($index)->view()` + `renderer->renderPlain()`, wraps
    the result in `FilterProcessResult` + `FilteredMarkup::create()` and stores it under
    `['processed']` (text-format filters are applied).
  - `convertUriToUrl()` — for values with a `uri`, adds a resolved `['url']` via
    `Url::fromUri(...)->toString()`.
  - `extractEntityReference()` — for `entity_reference_revisions` fields, loads
    `referencedEntities()` and recurses, adding `type`/`bundle`/`url`/id-key/`label`/`status`/
    `langcode` metadata per referenced content entity.
- **`removeNonFields()`** drops any array key not starting with `field`.
- **Caching helpers**: `getCacheContexts()` (source entity contexts + languages),
  `getCacheKeys([$extra])` (field name, target type, target id), `getCacheTags()`
  (`"{type}:{id}"` so the mirror invalidates when the source is saved).

## Computed `fetched` property

`EntityFieldFetchItem::setValue()` writes the Fetcher output into the computed `fetched` property
(main property). Because it is a non-internal computed property, the mirrored source data is
serialized with the host entity through normal entity loads and data APIs (e.g. JSON
normalization), in addition to being rendered by the formatter/widget.

## GraphQL field — `EntityFieldFetchFetched`

`src/Plugin/GraphQL/Fields/Entity/Fields/EntityFieldFetch/EntityFieldFetchFetched.php`,
`@GraphQLField(id = "fetched", name = "fetched", type = "Map", secure = true, provider =
"entity_field_fetch")`. Only discovered when the `graphql`/`graphql_core` modules are installed.
`resolveValues()` yields the item's `fetched` array after `convertKeysToCamel()` (Drupal→GraphQL
key casing; maps `bundle`→`entityBundle`, `type`→`entityType`, wraps entity-typed arrays under an
`entity` key) and `addPathToUri()` (adds `url.path` for `uri` values).

## Source-in-use delete protection

Two layers stop deleting a node/term that is a live fetch source:

1. **Access check** `entity_field_fetch.delete_allow_check` — `Access/DeleteAllowCheck.php`, tagged
   `access_check` for `_eff_delete_allow_check`. `RouteSubscriber::alterRoutes()`
   (`Routing/RouteSubscriber.php`) adds that requirement to `entity.node.delete_form` and
   `entity.taxonomy_term.delete_form`. `access()` returns `AccessResult::forbidden(...)` (and adds a
   warning message) when `SourceCheck::getIsSourceMessage()` reports the entity is a source; else
   `AccessResult::allowed()`.
2. **`hook_entity_predelete()`** (`entity_field_fetch.module`) — a backup for API/bulk deletions
   that bypass the delete form. It throws an `EntityStorageException` (HTTP 409) with the in-use
   message. Skipped under CLI (`PHP_SAPI === 'cli'`) so Drush operations are not blocked.

## `entity_field_fetch.source_check` — `Service/SourceCheck.php`

Injects `entity_field.manager`, `string_translation`. `getEffSources()` builds a map of all
`entity_field_fetch` field instances (`getFieldMapByFieldType('entity_field_fetch')`) keyed by
`"{source_type}:{source_id}"` → host `"{type}:{bundle}"` → field names (cached in-object per
request). `getIsSourceMessage()`/`isEffSource()`/`buildSourceMessages()` return a translated
"Cannot delete … because it is used as a source by …" message (fields JSON-encoded) when the given
entity is a fetch target, else NULL.

## Help hook

`entity_field_fetch_help()` renders `README.md` on `help.page.entity_field_fetch` — escaped in a
`<pre>` when `markdown` is absent, else run through the `markdown` filter.
