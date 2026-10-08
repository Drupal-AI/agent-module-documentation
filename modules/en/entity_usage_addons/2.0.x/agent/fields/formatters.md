<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Usage Addons — field formatters & Usage service

Two integer field formatters expose Entity Usage's "who references this entity" data on a display or
Views field. Both are placed on an entity's **ID** field (or an ID field in a View) and delegate to
the `entity_usage_addons.usage` service. Files: `src/Plugin/Field/FieldFormatter/*`,
`src/Service/Usage.php`.

## Install & place
1. `drush en entity_usage_addons` (dependency `entity_usage` is enabled automatically).
2. In **Entity Usage**, configure which entity types / fields are tracked. This add-on renders only
   what Entity Usage recorded.
3. Go to *Manage display* for the host entity (or edit a View), take the entity's **ID** field, and
   choose formatter **Entity Usage - Detailed** or **Entity Usage - Count**.

Both formatters return `TRUE` from `isApplicable()` and declare `field_types = {"integer"}`, so
they are offered on any integer field, but the ID field is the intended target: `viewValue()` reads
`$item->getEntity()->getEntityType()->id()` (entity type) and `$item->value` (entity id) and asks
Entity Usage for that entity's usage.

## `entity_usage_addons_formatter` — "Entity Usage - Detailed"
Class `EntityUsageAddonsFormatter`. Settings (`defaultSettings()` / `settingsForm()`):
- `max_expanded` (select 0/1/3/5/10/20/50/100, default 3) — expand into a table only while the usage
  count is `> 0` and `<= max_expanded`; otherwise fall back to the linked count.
- `show_fields` (checkboxes: `id`, `entity`, `status`, `type`; default `entity`) — which columns the
  detailed table renders.
- `show_header` (checkbox, default FALSE) — add a header row.

`viewValue()` logic: `getUsageTotal()` gives the count; if it is `0` or `> max_expanded` it returns
`linkedUsage()` (a count/link), else `detailedUsage()` (a table).

## `entity_usage_addons_formatter_count` — "Entity Usage - Count"
Class `EntityUsageAddonsFormatterCount`. No settings. `viewValue()` always returns
`linkedUsage($entityType, $entityId)`.

> Both formatters fetch the service with `\Drupal::service('entity_usage_addons.usage')` (the source
> carries a `TODO Dependency Inject` note); they do not inject it.

## `Usage` service (`entity_usage_addons.usage`)
Constructor args: `@entity_usage.usage`, `@entity_type.manager`, `@logger.factory`, `@current_user`.

- `getUsage($entityType, $entityId)` — loads the entity and returns
  `entity_usage.usage->listUsage($entity)`, an array keyed `[source_type][source_id] = count`.
  Returns `[]` if the entity cannot be loaded.
- `getUsageTotal($entityType, $entityId)` — sum of counts across all source types.
- `linkedUsage($entityType, $entityId)` — if the current user lacks the Entity Usage permission
  `access entity usage statistics`, returns the bare integer total. Otherwise wraps the total in a
  link to route `entity.{entityType}.entity_usage` and returns `Link::toString()`.
- `detailedUsage($entityType, $entityId, array $showFields, $showHeader)` — returns a
  `#theme => 'table'` render array (or integer `0` when there is no usage). For each source entity it
  loads it via storage and builds a row from the selected columns: `id` (raw id), `entity`
  (`getSourceEntityLink()`), `status` (Published/Unpublished from `$sourceEntity->status`, or empty),
  `type` (entity type id). Header cells are `t()` strings, added once.
- `getSourceEntityLink($source_entity, $text = NULL)` (protected) — access-aware link builder:
  label is `$source_entity->access('view label') ? label() : t('- Restricted access -')`; a link is
  produced only when `$source_entity->access('view')` is TRUE, otherwise the (possibly restricted)
  label text is returned unlinked. Prefers the `revision` link template, then `canonical`. Non-reusable
  `block_content` (Layout Builder inline blocks) and `paragraph` entities are resolved to their host:
  paragraphs via `getParentEntity()`, block_content via `entity_usage.usage->listSources()`.

## Notes for operators
- This module never writes content; it is display-only.
- Referencing labels/links honour per-viewer entity access (view label / view). The count link is
  gated by `access entity usage statistics`.
- An empty result means Entity Usage did not track the relationship, not that the entity is unused.
