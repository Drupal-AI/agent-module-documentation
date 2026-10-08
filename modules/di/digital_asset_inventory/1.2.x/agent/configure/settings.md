# Configuring Digital Asset Inventory

All settings live in `digital_asset_inventory.settings` (config schema provided). Three admin
sub-forms edit slices of it, all gated by `administer digital assets`:

- `digital_asset_inventory.settings` → `/admin/config/accessibility/digital-asset-inventory`
  (`ScannerSettingsForm`) — scanner + title-resolution options.
- `…/archive` (`ArchiveSettingsForm`) — enable/disable archiving, registry labels.
- `…/registry` (`RegistrySettingsForm`) — archive registry page content (only when archive enabled;
  route adds `_dai_archive_enabled: TRUE`).

## Feature flags (default OFF)
- `enable_archive` (false) — turns on the Archival Management System and its routes.
- `enable_manual_archive` (false) — allows manual archive entries.
- `allow_archive_in_use` (false) — permit archiving assets still in use.

These back the custom access checks (`_dai_archive_enabled`, `_dai_manual_archive_enabled`) so
archive routes 403/deny when the feature is off. See [../permissions/permissions.md](../permissions/permissions.md).

## Scanner settings
- `scan_lock_stale_threshold_seconds` (300) — when a held scan lock is considered stale.
- `scan_batch_time_budget_seconds` (10) — per-batch time budget.
- `scan_excluded_directories` (`[]`), `scan_excluded_filenames` (`[]`) — exclude from scans.

## Title resolution settings
- `title_resolution_enabled` (true).
- `title_resolution_timeout` (3s HTTP timeout).
- `title_resolution_max_per_cron` (50) — max external fetches per cron run.
- `title_resolution_retry_after_days` (7) — re-attempt window for unresolved items.

## Archive link / registry display
- `show_archived_label` (true) + `archived_label_text` ('Archived').
- `archive_registry_show_heading` / `archive_registry_heading` ('About This Archive').
- `archive_registry_styled_box` (true).
- `archive_registry_intro` — HTML shown on `/archive-registry` (ships with ADA Title II boilerplate).

## Asset type map (`asset_types`)
Large map keyed by type id → `{label, category, extensions[], mimes[], url_patterns[]}`. Local
types match by extension/MIME (pdf, word, excel, images, A/V, compressed, …); external types match
by `url_patterns` (Google Docs/Sheets/Slides/Drive/Forms/Sites, YouTube, Vimeo, SharePoint,
OneDrive, Dropbox, Box, DocuSign, Qualtrics, MS Forms, SurveyMonkey, Typeform, Canvas, Panopto,
Kaltura, Zoom, SlideShare, Prezi, Issuu, Canva, Adobe Acrobat). Add/adjust providers by editing
this config.

## Shipped config
- Views (`config/install/views.view.*`): `digital_assets`, `digital_asset_usage`,
  `digital_asset_archive`, `dai_orphan_references`, `public_archive`.
- Optional role (`config/optional/user.role.digital_asset_manager.yml`): `digital_asset_manager`.
- Image/other config in `config/install`.

Override any key via `settings.php` (`$config['digital_asset_inventory.settings'][…]`) as usual.
