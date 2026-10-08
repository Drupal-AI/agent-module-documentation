<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Detection, routes and rendering

No storage table exists — "usage" is recomputed live per request and cached. Enable with
`drush en entity_usage_light`. `hook_install` (`entity_usage_light.install`) seeds a
standard-profile default: sets `active_on.node = TRUE` and gives every node bundle the
third-party setting `entity_type_ids = ['media' => 'media']`. `hook_uninstall` strips those
third-party settings and deletes the config.

## How the tab is wired

1. `EntityTypeInfo::entityTypeAlter()` (`src/EntityTypeInfo.php`, via `hook_entity_type_alter`)
   — for each entity type whose `active_on.<id>` is TRUE and that has a default/edit form
   class plus an `edit-form` link template, sets link template
   `entity_usage_light` = `/<id>/{<id>}/usage-light`.
2. `Routing\RouteSubscriber::alterRoutes()` — for every entity type carrying that link
   template, adds route `entity.<id>.usage_light`:
   - `_controller` = `UsageController::list`, `_title` = "Usage".
   - gated by the `access entity_usage_light information` permission.
   - options: `_admin_route: TRUE`, `_usage_entity_type_id: <id>`, and a `parameters` entry
     upcasting `{<id>}` to `entity:<id>`.
   - Subscribes at `RoutingEvents::ALTER` priority 100.
3. `Plugin\Derivative\LocalTask` (`entity_usage_light.links.task.yml`) derives a "Usage"
   local task per entity type that has the link template, based on `canonical` (else
   `edit_form`), weight 100.
4. `EntityTypeInfo::entityOperation()` (`hook_entity_operation`) adds a "Usage" operation on
   entities with a `usage_light` link template — only if the current user has
   `access entity_usage_light information`.

## Detection algorithm — `UsageController::list()`

- Resolves the host entity via `getEntityFromRouteMatch()` (reads route option
  `_usage_entity_type_id`, then `$route_match->getParameter(...)`).
- Loads the host **bundle's** third-party settings (`entity_usage_light.entity_type_ids`,
  `entity_type_views`); if `entity_type_ids` is empty it renders only a "Configure" link.
- Cache: `cid = entity_usage_light:<host_type>:<host_uuid>` in `cache.default`, tagged
  `<host_type>:<host_id>`, `Cache::PERMANENT`; on a miss it computes then stores (unless the
  host `isNew()`).
- `extractEntityIdsFromEntity(string $entity_type_id, EntityInterface $entity)` collects IDs
  of the target type by:
  - `$entity->referencedEntities()` filtered to the target type;
  - recursing into `entity_reference`, `entity_reference_revisions`, and `layout_section`
    fields — `layout_section` pulls Layout Builder `inline_block` component
    `block_revision_id`s into `referencedIds['block_content']`;
  - `extractEntityIdsFromText()` for `text` / `text_long` / `text_with_summary` fields.
  - Results deduped with `array_unique` + `array_filter` (keeps `'0'` for the anonymous
    user reference).
- `extractEntityIdsFromText(string $entity_type_id, string $text)` parses the HTML with
  `Html::load()` + `DOMXPath`, matches
  `//*[@data-entity-type="<id>" and normalize-space(@data-entity-uuid)!=""]`, and resolves
  each `data-entity-uuid` to an ID via an entity query on the target type
  (`condition('uuid', $uuid)`). This is how CKEditor-embedded media are found.

## Rendering

- For each target entity type with results: if Views is enabled and the bundle configured
  `<id>_usage_light_view`, it runs that View with `preExecute([implode('+', $ids)])`;
  otherwise `getTable()`.
- `getTable(string $entity_type_id, array $ids)` loads the entities and builds a
  `#type => table` (library `entity_usage_light/tables`, `css/tables.css`) with a
  view link (canonical, or the direct file URL via `FileUrlGenerator` for `file` entities)
  and either an "Edit" link or the entity list builder's operations.

## Config surface referenced here

- Config object `entity_usage_light.settings` → `active_on` sequence of booleans.
- Per-bundle third-party settings under key `entity_usage_light`: `entity_type_ids`,
  `entity_type_views` (schema aliased for `node.type.*`, `media.type.*`,
  `taxonomy.vocabulary.*` in `config/schema/entity_usage_light.schema.yml`).

See [config/settings.md](../config/settings.md).
