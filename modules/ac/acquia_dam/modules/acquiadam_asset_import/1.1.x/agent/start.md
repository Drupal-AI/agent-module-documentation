<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia DAM Bulk Asset Import — agent index

Submodule of **acquia_dam**. Bulk-creates Drupal media entities for DAM (Widen) assets in
configured **categories** / **asset groups**, filtered to chosen media types. Config UI:
`/admin/config/acquia-dam/bulk-import` (route `acquiadam_asset_import.configuration`, needs the
parent's `administer acquia_dam` permission + a DAM-authenticated site). Settings object:
**`acquiadam_asset_import.settings`**. Depends on `acquia_dam`.

- **The two mapping keys (`categories`, `asset_groups`), the config form, how mapping works** →
  [configure/bulk-import.md](configure/bulk-import.md)
- **The three Drush commands and their `--batch-size` / `--limit` options** →
  [drush/commands.md](drush/commands.md)

Key facts:
- `acquiadam_asset_import.settings`: `categories` (map Widen category UUID → [local media type
  ids]) and `asset_groups` (map asset group UUID → [media type ids]). Install default: both `{}`.
- Import is queue-based: assets are enqueued into the **`acquia_dam_asset_import`** queue and a
  QueueWorker (`AssetImporter`) creates a media entity per asset.
- Drush: `acquia-dam:queue-import-assets` (`ad:qia`), `acquia-dam:process-import-queue`
  (`ad:piq`), `acquia-dam:import-assets` (`ad:ia`).
- Enumerating/creating assets requires a live DAM connection; the config, form, queue and
  commands are inspectable offline.
