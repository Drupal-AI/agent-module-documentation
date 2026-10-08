<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Usage Report — route, controller pipeline & services

The whole module is one admin page. This documents how it is wired and what each report section is
built from, so you don't have to read the ~580-line controller.

## Install / enable

```
composer require drupal/block_usage_report   # (no composer.json ships; download from drupal.org)
drush en block_usage_report
```

No configuration step, no config objects, no schema, no permissions to grant beyond core's
existing **`access site reports`**. After enabling, the page is linked under
**Administration → Reports** (`Block usage`).

## Route & access

- Route id **`block_usage_report.report`** — `block_usage_report.routing.yml`.
- Path **`/admin/reports/block-usage`**, `_controller: \Drupal\block_usage_report\Controller\BlockUsageReportController::build`,
  `_title: 'Block Usage'`.
- Access: `_permission: 'access site reports'` — Drupal core's admin-reports permission (the same
  gate as the status report / dblog). It is **not** `access content` and **not** `_access: TRUE`,
  so anonymous users cannot reach it.
- Menu link `block_usage_report.report` (`block_usage_report.links.menu.yml`), parent
  `system.admin_reports`, weight 10.

## Services (`block_usage_report.services.yml`)

- `logger.channel.block_usage_report` — a `logger.channel_base` child, channel name
  `block_usage_report`. Used by the controller's paragraph-resolution error/warning logging.
- `layout_block_finder` → `Drupal\block_usage_report\LayoutBlockFinder`, constructor args
  `@database`, `@entity_type.manager`.

## Controller build pipeline — `BlockUsageReportController::build()`

`create()` resolves optional integrations up front: `module_handler->moduleExists('layout_builder')`
→ injects the `layout_block_finder` service (else `NULL`); `moduleExists('block_field')` → a bool;
`moduleExists('fixed_block_content')` + a storage handler → the `fixed_block_content` storage (else
`NULL`). It also injects `block` + `block_content` storages and their list builders, the block
plugin manager, DB connection, bundle info and display repository.

`build()` returns a render array; each non-empty group is a `#type => details` wrapper containing a
`#theme => 'table'`. Sections (in order):

1. **Enabled / Disabled blocks.** Iterates `blockStorage->loadMultiple()`, **skipping any block
   whose `getTheme()` != `system.theme` `default`** (default-theme only, by design). Splits on
   `$block->status()`. Columns: Name `label (id)`, Provider (`settings['provider']`), Type, Region,
   Operations (from `blockListBuilder->getOperations()`). For `provider == 'block_content'` the
   `block_content:<uuid>` plugin is matched against `BlockContentPseudoEntity::loadMultiple()` to
   show the bundle (or `[broken/missing]`), and the uuid is recorded as "found". For
   `provider == 'fixed_block_content'` the fixed block's associated custom block bundle/id is shown
   and its uuid recorded. Rows sorted by provider, then type, then name.
2. **Blocks embedded in content** (`getFieldedBlockInfo()`, only if `block_field` present). Loads
   `field_storage_config` of type `block_field`, then `SELECT entity_id, <field>_plugin_id FROM
   {entity_type}__{field_name}` per instance. For each, `getOwningEntity()` loads the parent —
   **recursively climbing `paragraphs_item_field_data.parent_id/parent_type`** until a non-paragraph
   owner is found (orphans logged + skipped). Unpublished parents are omitted. Columns: block
   admin_label `(plugin_id)`, provider, parent-entity link, `EntityType: bundle`, owning-entity
   operations.
3. **Blocks in bundle-default layout templates** (only if `layout_builder` present) — from
   `LayoutBlockFinder::getDefaultLayoutBlocks()`. Columns: Entity type, Bundle, Display mode,
   Plugin ID.
4. **Blocks in entity-specific overridden layouts** (only if `layout_builder` present) — from
   `getOverriddenLayoutBlocks()`. Loads each entity by id+langcode to render an edit-form (or
   canonical) link. Columns: Entity type, Language code, Entity title (link), Plugin ID.
5. **Unplaced custom blocks.** Every `BlockContentPseudoEntity` whose uuid was never recorded as
   "found" across the sections above — i.e. the custom blocks with no placement. Columns: Name
   `label (id)`, Type, Operations. This is the "candidates for deletion" list.

Empty groups are dropped, so a site without Layout Builder / block_field simply shows the two
region tables plus unplaced.

## `LayoutBlockFinder` (Layout Builder discovery)

- `getDefaultLayoutBlocks()` — DB query on the `config` table for `core.entity_view_display.%`
  names whose serialized `data` contains `layout_builder`; parses the config name into
  `entity_type / bundle / view_mode`, `unserialize()`s the blob, walks
  `third_party_settings.layout_builder.sections[].components[]`, and collects each component's
  `configuration.id` **excluding** `field_block:` / `extra_field_block:`. Cached in a property.
- `getOverriddenLayoutBlocks()` — for every `ContentEntityType`, if `{type}__layout_builder__layout`
  exists, selects non-deleted rows and `@unserialize()`s `layout_builder__layout_section` into a
  `\Drupal\layout_builder\Section`; keeps a component only if `isOverride()` says it is not already
  in that bundle's default layout (and is not a field block).
- `isOverride()` — returns TRUE when the bundle has no default-layout blocks, or the plugin id is
  absent from the bundle's default set.

## `BlockContentPseudoEntity`

A lightweight substitute for a full `block_content` entity load. `loadMultiple()` runs one query
joining `block_content` (for `uuid`) with `block_content_field_data` (`id`, `type`, `info`) and
returns objects exposing `uuid()`, `bundle()` (the `type`), `label()` (the `info`) and `id()`. Used
to name placed custom blocks and to derive the unplaced set without hydrating every block entity.

## Operating notes

- **Default-theme scope:** region-placed blocks in any non-default theme are intentionally not
  listed. Switch the default theme to audit another theme's block layout.
- **Read-only:** no writes, no queue, no cron; safe to hit repeatedly. It does re-parse config and
  Layout Builder tables on each uncached request, so on very large sites the page is proportionally
  heavy.
- All output is rendered through core `#theme => 'table'` render arrays (auto-escaped); labels,
  regions and plugin ids appear as plain text.
- Note: the `block_content:` prefix checks in the controller use `str_starts_with('block_content:',
  $plugin_id)` (arguments in haystack/needle order that never matches) in a couple of the
  uuid-recording branches — a benign quirk that can leave some layout-embedded custom blocks
  double-listed under "unplaced"; it does not affect access or correctness of the placement tables.
