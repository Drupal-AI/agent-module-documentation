<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bulk-imports Acquia DAM (Widen) assets from named categories into Drupal media entities via cron and a queue.

---

Acquia DAM Asset Importer extends the Media: Acquia DAM (`media_acquiadam`) integration so you can pull the
contents of one or more Acquia DAM **categories** into Drupal as standalone media entities, without first
attaching each asset to another Drupal entity. You list category names and pick a target media bundle on a
settings form; on every cron run the `DamImporter` service queries the DAM API (through the
`media_acquiadam.acquiadam` client) for each category, queues any asset IDs not already present in Drupal, and a
`dam_worker` queue worker creates the corresponding media entities. It adds no public routes, permissions, or
Drush commands — DAM authentication and the actual asset/file handling stay in the base `media_acquiadam` module.
Note: the project is deprecated (functionality absorbed into the Acquia DAM project) and marked obsolete.

---

- Bulk-import the contents of Acquia DAM categories into Drupal.
- Create Drupal media entities from Widen-backed DAM assets.
- Import assets without first attaching them to another Drupal entity.
- Extend the Media: Acquia DAM (`media_acquiadam`) integration.
- Configure a newline-separated list of DAM category names to import.
- Choose which media bundle (an `acquiadam_asset` source type) receives imports.
- Toggle importing on/off with an "Enable DAM import" checkbox.
- Run imports automatically on cron (no manual trigger needed).
- Skip assets already imported (dedupe by `field_acquiadam_asset_id`).
- Queue asset IDs and process them in the background via the `dam_worker` queue worker.
- Page through large categories in batches of 100 assets via the DAM API.
- Assign imported media to user 1 (admin) by default.
- Store the imported DAM asset ID on each media entity's `field_acquiadam_asset_id` field.
- Keep a Drupal media library synced to selected DAM categories over time.
- Seed a site's media library from an existing Acquia DAM account.
- Reuse DAM credentials already configured in `media_acquiadam` (no separate auth).
- Limit imports to specific brand/campaign/category folders in DAM.
- Populate media for editors to reference elsewhere without manual uploads.
- Support Drupal 10.1+ and 11 sites using the Widen-backed Acquia DAM service.
- Migrate a config value from the legacy "folders" key to "categories" on update (2.0.x).
