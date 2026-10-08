<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crop Usage Report (crop_usage_report) — agent index

An admin **report** that lists image **media** entities missing one or more manually-applied
**crop types** (Crop API `crop` entities). Package `Media`. Core `^11`, PHP `>=8.3`. License
GPL-2.0-or-later. Version 1.0.0 (1.0.x).

Dependencies: core **`media`** + **`file`**, contrib **`crop`** (drupal/crop). Complements
Image Widget Crop but does not require it as a code dependency.

## What it provides

- **Service** `crop_usage_report.audit_service` = `CropAuditService`
  (`src/CropAuditService.php`) — the audit engine. Also injected into the Drush command.
- **Controller** `CropAuditReportController` (`src/Controller/CropAuditReportController.php`) —
  `report()` (HTML table), `export()` (streamed CSV), `refresh()` (cache invalidate + redirect).
- **Settings form** `CropAuditSettingsForm` (`src/Form/CropAuditSettingsForm.php`) at
  `/admin/config/media/crop-report`.
- **Drush command** `crop:audit` (alias `crop-audit`) in `src/Commands/CropAuditCommands.php`,
  registered via the `drush.command` service tag.
- **Config** object `crop_usage_report.settings` (`crop_types`, `media_bundles`, `batch_size`);
  schema in `config/schema/crop_usage_report.schema.yml`, install defaults in `config/install/`.
- **Permissions** `view crop usage report`, `administer crop usage report`
  (`crop_usage_report.permissions.yml`).

## Routes (crop_usage_report.routing.yml)

| Route | Path | Permission |
|---|---|---|
| `crop_usage_report.report` | `/admin/reports/crop-usage` | `view crop usage report` |
| `crop_usage_report.export` | `/admin/reports/crop-usage/export` | `view crop usage report` |
| `crop_usage_report.refresh` | `/admin/reports/crop-usage/refresh` | `view crop usage report` |
| `crop_usage_report.settings` | `/admin/config/media/crop-report` | `administer crop usage report` |

Menu links: report under `system.admin_reports`, settings under `system.admin_config_media`
(`*.links.menu.yml`); Report/Settings local tasks on the report page (`*.links.task.yml`).

## Solution docs

- **How the audit works, config keys, caching, routes, permissions, the report UI** →
  [audit/how-it-works.md](audit/how-it-works.md)
- **The `drush crop:audit` command and its options / output formats** →
  [drush/crop-audit.md](drush/crop-audit.md)

## Mechanism in one paragraph

`CropAuditService::runAudit()` resolves audited crop types (`getAuditCropTypes()`) and image
bundles (`getImageMediaBundles()` — media types whose source `instanceof
\Drupal\media\Plugin\media\Source\Image`), queries media in those bundles, chunks by
`batch_size`, keeps only files whose MIME is in `CROPPABLE_MIME_TYPES`, and does one
`crop` `loadByProperties(['uri' => …])` per batch. A crop type with no `crop` entity for a
file's URI is "missing." Results (mid, name, bundle, filename, uri, missing_types, edit_url)
are cached permanently under tag `crop_usage_report`; `refresh()` / `invalidateCache()` clears
that tag. No custom entities, no plugin types, no hooks.
