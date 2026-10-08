<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Usage Report (block_usage_report) — agent index

A single read-only admin **report** at `/admin/reports/block-usage` that lists which blocks are
placed in the site's **default theme** (enabled vs disabled, and region), plus placements no core
screen summarises: `block_field` content embeds, Layout Builder bundle-default and per-entity
override blocks, `fixed_block_content` associations, and **unplaced custom blocks**. Package
`Custom`. No hard dependencies beyond core. `core_version_requirement: ^9 || ^10 || ^11`.
`php: 8.0`. License GPL-2.0-or-later. Version 1.0.4.

- **The report route, permission, controller build pipeline, the `LayoutBlockFinder` service, and
  the optional module integrations** → [routes/overview.md](routes/overview.md)

## What it actually is

- **No entities, no plugins, no config, no permissions, no Drush, no hooks, no submodules.** It
  ships one route, one menu link, two services, and three PHP classes.
- Route `block_usage_report.report` (`block_usage_report.routing.yml`): path
  `/admin/reports/block-usage`, `_controller: BlockUsageReportController::build`, requirement
  `_permission: 'access site reports'` (core's admin-reports permission — not `access content`).
- Menu link `block_usage_report.report` (`.links.menu.yml`) under `system.admin_reports`
  (Administration → Reports), weight 10.
- Services (`block_usage_report.services.yml`): `logger.channel.block_usage_report` (a logger
  channel) and `layout_block_finder` → `Drupal\block_usage_report\LayoutBlockFinder`
  (args `@database`, `@entity_type.manager`).

## Classes (from source)

- `Controller\BlockUsageReportController` — `build()` returns a render array of `details`-wrapped
  `#theme => 'table'` sections. Auto-detects optional modules in `create()`:
  `layout_builder` → injects `LayoutBlockFinder`; `block_field` → boolean flag; `fixed_block_content`
  → its storage handler. Only blocks whose `getTheme()` equals `system.theme` `default` are listed.
- `LayoutBlockFinder` — `getDefaultLayoutBlocks()` reads the `config` table for
  `core.entity_view_display.*` rows containing `layout_builder`; `getOverriddenLayoutBlocks()`
  reads each content entity type's `{type}__layout_builder__layout` table and keeps only true
  overrides via `isOverride()`. Both filter out `field_block:` / `extra_field_block:` plugins.
- `BlockContentPseudoEntity` — a lightweight value object (`loadMultiple()` joins `block_content` +
  `block_content_field_data`) exposing `uuid()/bundle()/label()/id()`, used to match placed
  `block_content:<uuid>` plugins and compute the "unplaced" set.

## Report sections it emits

Enabled blocks · Disabled blocks · Blocks embedded in content (`block_field`) · Blocks in
bundle-default layout templates (`layout_builder`) · Blocks in entity-specific overridden layouts
(`layout_builder`) · Unplaced custom blocks. Empty sections are omitted.
