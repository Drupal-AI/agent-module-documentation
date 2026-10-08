<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# D7 Webform Import (d7_import_webform) — agent index

Submodule of **d7_import**. Imports Drupal 7 Webform (7.x-4.x) forms from `webforms.xml` as D11
`Webform` config entities. Package `Migration`. Core `^11`. Depends on **d7_import** and
**webform:webform**. License GPL-2.0-or-later. Version 1.2.0. No routes, no config, no permissions,
no hooks — one service + two Drush commands.

- **The importer service (component/settings/handler mapping)** →
  [services/webform-importer.md](services/webform-importer.md)
- **Drush commands (`d7-import:webforms`, `d7-import:webforms-purge`)** →
  [commands/drush.md](commands/drush.md)
- **Parent module** →
  [../../../../d7_import/1.2.x/agent/start.md](../../../../d7_import/1.2.x/agent/start.md)

## What it actually is

- One service: `d7_import_webform.webform_importer` → `WebformImporter`
  (`src/Service/WebformImporter.php`), constructed with `entity_type.manager`,
  `plugin.manager.webform.handler`, `logger.factory` (`d7_import_webform.services.yml`).
- One Drush command class: `D7ImportWebformCommands` (`drush.services.yml`, tag `drush.command`),
  commands `d7-import:webforms` (alias `d7iwf`) and `d7-import:webforms-purge` (alias `d7iwfp`).
- No web routes or forms of its own — you run it via Drush, or it is invoked by the parent
  module's `d7-import:all` when `\Drupal::hasService('d7_import_webform.webform_importer')` is true.

## Mechanism (from source)

- `WebformImporter::import()` iterates `<webform>` elements, derives a ≤32-char machine id from the
  source title + nid (`buildWebformId`), skips ones that already exist, then builds a `Webform`
  entity: `parseComponents()` → `buildElements()` (nesting by `pid`, wizard-page partitioning by
  `pagebreak`) → `parseSettings()`/`mapSettings()` → save → `parseEmailHandlers()` add `email`
  handlers via the handler plugin manager.
- Component types map through `COMPONENT_TYPE_MAP` (see service doc); unmapped types are logged and
  skipped. D7 `extra` blobs are `unserialize()`d with **`allowed_classes => FALSE`** (with a
  length-prefix repair for `\r\n`-normalised strings).
- `status` = D7 `{webform}.status` (open/closed), deliberately NOT the node's published flag.

## Notes

- CLI/admin only — no web-facing route. Imports never overwrite an existing Webform (purge first
  to re-import). Submissions, conditional logic and per-role access are out of scope.
