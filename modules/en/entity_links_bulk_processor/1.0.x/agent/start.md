<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Links Bulk Processor (entity_links_bulk_processor) — agent index

Bulk-rewrites HTML in entity **text fields** across a site: internal/alias links → UUID-based
entity links, `mailto:`/`tel:`/`sms:`/`fax:` validation, CSS-class remapping, inline-style/title
cleanup, external→internal URL conversion, and legacy **Drupal 7 media** → `<drupal-media>`.
Runs from an admin UI, a batch, or Drush. Package `Content`. Core `^10 || ^11`. License
GPL-2.0-or-later. Version 1.0.0-alpha9.

- Depends on core **`filter`**, **`path_alias`**; recommends (hook_requirements) **pathauto**,
  **redirect**. No composer.json in the project.
- One service: **`entity_links_bulk_processor.entity_type_discovery`** (`Service/EntityTypeDiscovery`).
- Provides **1 permission**, **config schema**, and a **Drush command**. No plugin types, no
  entity types, no filter/formatter plugin.
- Ships submodule **`entity_links_autosave`** (own tree:
  [modules/entity_links_autosave/1.0.x](../../modules/entity_links_autosave/1.0.x/agent/start.md)).

## The one permission (all web routes)

`administer entity links bulk processor` — `restrict access: true` (in
`entity_links_bulk_processor.permissions.yml`). Gates every route below. Bulk processing modifies
content in the database, so treat it as a trusted operator capability; preview/dry-run first.

## Routes & forms (`entity_links_bulk_processor.routing.yml`, all `_permission` above)

- `.admin` → `/admin/config/content/entity-links-bulk-processor` — `Form/EntityLinksBulkProcessorForm`
  (main form: select entity types/bundles/IDs, preview, generate Drush command, link to Process Now).
- `.process` → `.../process` — `Form/ProcessNowForm` (4-step wizard: select → preview → confirm
  (type `PROCESS`) → batch results).
- `.settings` → `.../settings` — `Form/SettingsForm` (writes config object; ~50 keys).
- `.discover_css` → `.../discover-css-classes` — `Form/CssClassDiscoveryForm` (scan classes, import
  mappings, CSV export).

## Solution docs

- **Config object, schema keys, routes, permission, forms** →
  [config/settings.md](config/settings.md)
- **The transformation pipeline, helper functions, batch, Drush command, service** →
  [api/processing.md](api/processing.md)

## Key facts (from source)

- Core rewrite is the procedural `entity_links_bulk_processor_process_attributes($text, &$errors,
  &$actions, $langcode)` in `entity_links_bulk_processor.module` (~2,898 lines), using
  `DOMDocument`/`DOMXPath`. All forms, the batch, autosave, and Drush call it.
- Entity resolution targets `node`, `media`, `taxonomy_term`; UUID lookups hit base tables via the
  DB API. Alias resolution uses `path_alias.manager`; redirect following queries the `redirect`
  table (only if that module exists).
- Drush command `entity-links:bulk-process` (alias `elbp`) in
  `src/Drush/Commands/EntityLinksBulkProcessorCommands.php`; registered in `drush.services.yml`.
- Config object: **`entity_links_bulk_processor.settings`** (`config/install` + `config/schema`).
