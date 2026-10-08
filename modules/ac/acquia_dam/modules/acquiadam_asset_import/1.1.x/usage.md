<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bulk Asset Import creates Drupal media entities in bulk for Acquia DAM (Widen) assets that live in configured Widen categories or asset groups, optionally filtered to specific local media types, driven by a queue and Drush commands.

---

This submodule of Acquia DAM adds a bulk-import workflow so you do not have to embed assets one at a time. On its configuration form (`/admin/config/acquia-dam/bulk-import`, route `acquiadam_asset_import.configuration`, gated by the parent's `administer acquia_dam` permission and a DAM-authenticated access check) you map remote **Widen category UUIDs** and **asset group UUIDs** to one or more local DAM media types; those two maps are stored in the `acquiadam_asset_import.settings` config object under `categories` and `asset_groups`. Importing is a two-phase, queue-based process: a queue service enumerates the matching assets from the DAM and enqueues them into the `acquia_dam_asset_import` queue, and a QueueWorker (`AssetImporter`) then creates a media entity per asset in batches. Three Drush commands drive it — `acquia-dam:queue-import-assets` (enqueue), `acquia-dam:process-import-queue` (process, with `--batch-size` and `--limit`), and `acquia-dam:import-assets` (queue + process in one go). Enumerating and creating assets talks to the DAM API and needs a live, authenticated connection; the mapping configuration, the config form, the queue, and the Drush commands all exist and are inspectable without one. The module also ships update hooks that migrate configuration from the older contributed `acquiadam_asset_import` module.

---

- Import every asset in a Widen "Product photography" category as Image media entities in one run.
- Seed a new Drupal site with a media library mirrored from selected DAM categories.
- Map a Widen category UUID to the `acquia_dam_image_asset` media type for import.
- Map a Widen asset group to a specific local media type (e.g. video assets → `acquia_dam_video_asset`).
- Filter a category import down to only certain media types you care about.
- Queue all configured assets with `drush acquia-dam:queue-import-assets` (alias `ad:qia`).
- Process the import queue in batches with `drush acquia-dam:process-import-queue --batch-size=50`.
- Limit a processing run to the first N assets with `--limit=100`.
- Queue and import in a single command with `drush acquia-dam:import-assets`.
- Run large imports during off-peak hours via cron/queue processing.
- Keep the Drupal media library in sync with curated DAM categories over time.
- Import assets for multiple categories by configuring several category→media-type mappings.
- Reduce memory use on big imports with a smaller `--batch-size`.
- Migrate configuration automatically from the old contributed bulk-import module via update hooks.
- Give editors a ready-made set of media entities instead of manual embedding.
- Bulk-create media for a marketing campaign's asset group ahead of launch.
- Reconcile which DAM categories should populate the site by editing the settings map.
- Inspect `acquiadam_asset_import.settings` to see which categories/asset groups are configured.
- Troubleshoot imports by watching the `acquia_dam_asset_import` queue depth.
- Schedule periodic re-imports to pick up newly added DAM assets in configured categories.
- Restrict imports to a subset of media types to avoid importing unwanted asset kinds.
