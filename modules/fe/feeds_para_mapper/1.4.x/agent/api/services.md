<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Architecture: the wrapper_target plugin + services

Grounded in `feeds_para_mapper.services.yml`, `src/Feeds/Target/WrapperTarget.php`,
`src/Mapper.php`, `src/Importer.php`, `src/RevisionHandler.php`, `src/Utility/TargetInfo.php`,
and `feeds_para_mapper.module`. This module exposes **no `*.api.php`** — it invites no hooks of its
own. You rarely call these services directly; this doc explains behavior so an agent can reason
about and debug imports.

## The `wrapper_target` FeedsTarget plugin

`Drupal\feeds_para_mapper\Feeds\Target\WrapperTarget` — `@FeedsTarget(id="wrapper_target",
field_types={"entity_reference_revisions"})`, extends `FieldTargetBase`, implements
`ConfigurableTargetInterface`. It is a **wrapper** around the real leaf field's own target plugin
(stored as `$this->targetInstance`, built in `createTargetInstance()` from the leaf field's recorded
`plugin` id).

- `static targets(array &$targets, FeedTypeInterface $feed_type, array $definition)` — called by
  Feeds to advertise targets. It asks `Mapper::getTargets($entity_type, $bundle)` for the paragraph
  leaf fields, clones each, temporarily sets its `field_type` to `entity_reference_revisions`, builds
  a `:`-joined label, and registers it under a unique id (`{last_host_bundle}_{field_name}`,
  de-duplicated with a numeric suffix).
- `setTarget(FeedInterface $feed, EntityInterface $entity, $field_name, array $values)` — called per
  row. Skips empty values (`valuesAreEmpty()`), restores the leaf field's **original** field type
  (import must not persist the faked `entity_reference_revisions` type), then delegates to
  `Importer::import(...)`.
- Config form: `defaultConfiguration()` / `buildConfigurationForm()` add the **Maximum Values**
  element when `Mapper::getInfo($field,'has_settings')` is true; `getSummary()` appends
  `Maximum values: N` under the wrapped plugin's summary.
- `calculateDependencies()` adds the target field **and every parent field** in its path as config
  dependencies (`Mapper::loadParentFields()`).

## Services (`feeds_para_mapper.services.yml`)

### `feeds_para_mapper.mapper` — `Mapper`
Discovers what can be mapped and records per-field metadata.
- `getTargets($entityType, $bundle): FieldConfigInterface[]` — paragraph leaf fields (that have a
  Feeds target plugin) reachable from the entity's Paragraphs fields.
- `findParagraphsFields($entity_type, $bundle)` — the entity's `entity_reference_revisions` fields.
- `getSubFields($target, …)` — recurses referenced paragraph bundles (respecting enabled/allowed
  bundles via `getEnabledBundles()`), skipping the wrapping field itself and `feeds_item`; sets
  `has_settings` when both host and leaf are multi-valued; computes each field's **`path`**.
- `getInfo()` / `updateInfo()` — read/write the `TargetInfo` object stored on a `FieldConfig` as the
  `target_info` property. `getMaxValues()` — clamp the configured max to the field cardinality.
  `loadParentFields()` — reload the `FieldDefinition` chain from a field's path.

### `feeds_para_mapper.importer` — `Importer`
Writes values into the Paragraphs tree during a single `setTarget()` call.
- `import($feedType, $feed, $entity, $target, $configuration, $values, $instance)` — entry point.
- `sliceValues()` chunks values by **Maximum Values**; `initHostParagraphs()` decides whether to
  reuse found/loaded paragraphs, append new ones, or build the host chain from scratch
  (`createParents()` → `createParagraph()`), duplicating the last paragraph for overflow
  (`duplicateExisting()`); `setValue()` writes through the **wrapped leaf plugin's** `setTarget()`.
- On an existing host entity it records touched paragraphs on `$entity->fpm_targets` (and each
  field's `target_info->paragraphs`) so `RevisionHandler` can finish the job after save.

### `feeds_para_mapper.revision_handler` — `RevisionHandler`
Invoked from `hook_entity_update` when `$entity->fpm_targets` is set.
- `handle($entity)` → `checkUpdates()` calls `createRevision()` on each already-saved touched
  paragraph (`setNewRevision(TRUE)` + `isDefaultRevision(TRUE)` + `save()`), then
  `updateParentRevision()` points the host field's `target_revision_id` at the new revision
  (workaround for entity_reference_revisions issue #2984540).
- `cleanUp()` reloads attached paragraphs (`Importer::loadTarget()`) and `removeUnused()` detaches
  paragraphs no longer referenced — but keeps any still holding values in an "in common" sibling
  field. Data is pruned from the host field, not hard-deleted mid-flight.

## `TargetInfo` (state carried on the field)

`Drupal\feeds_para_mapper\Utility\TargetInfo` is a plain object set on a **cloned** `FieldConfig`
via `->set('target_info', …)` (not persisted to config). Properties: `type` (the field's real type),
`plugin` (the wrapped Feeds target plugin definition), `path` (ordered host chain: each item has
`bundle`, `host_field`, `host_entity`, `host_field_bundle`, `order`), `in_common` (sibling leaf
fields sharing the same host), `has_settings`, `max_values`, `properties`, and `paragraphs`
(entities touched during import).

## Hooks this module implements

- `hook_feeds_targets_alter()` — removes the raw `paragraphs` target from the feed type's mappings
  (so you map to sub-fields), saving the feed type and warning "please refresh the page".
- `hook_entity_update()` — if the saved entity carries `fpm_targets`, hands off to
  `feeds_para_mapper.revision_handler`.
- `hook_help()` — renders `README.txt` on `help.page.feeds_para_mapper`.
