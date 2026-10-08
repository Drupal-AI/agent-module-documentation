<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
External Entities Manager (xnttmanager) is an administrator interface for the External Entities module that inspects external-entity field mappings and imports/synchronizes external-entity data into local Drupal node content, on demand or on a schedule.

---

Install it with Composer (`composer require drupal/xnttmanager`, which pulls `drupal/external_entities` ^3.0 beta) and enable it with the External Entities module; there is no settings page — everything is reached from tabs on the **External Entity Types** page and a "Tools" menu entry under `/admin/structure/external-entity-types`, all gated by the existing **"Administer external entity types"** permission. On **Manage** (`/admin/structure/external-entity-types/manage`) you pick a type (only types whose required fields are fully mapped appear), **Inspect** its field-to-source mapping, run a **Batch process** to load (optionally save or annotate) every entity as a health check, or experimentally **export/import** a type's whole config as a YAML file. On **Synchronize** (`/admin/structure/external-entity-types/sync`) you choose a type and either **Synchronize now**, get **statistics** (missing/different/orphan counts), or **create a cron**: xnttmanager will auto-create a matching `node` bundle (or target an existing content type), clone the external fields onto it, add hidden `xnttid`/`xntttype` key fields, then create, update and (optionally) delete local nodes to mirror the source. Scheduled syncs are stored as `xnttsync` config entities with a `frequency` (e.g. `30m`, `2h`, `1d`) and run from `hook_cron` (never more often than the site's own cron); the **Integrity** tab detects and re-saves field configs whose dependencies drifted. Its main purpose is importing into local Drupal the data aggregated from many sources via the External Entities Multiple Storage (`xnttmulti`) plugin, but it works with any External Entities storage backend.

---

- Import external-entity records into local Drupal nodes.
- Auto-create a local content type mirroring an external entity type.
- Target an existing node bundle for synchronized content instead of a new one.
- Clone all mapped external fields onto the local bundle automatically.
- Keep hidden `xnttid`/`xntttype` key fields on synchronized content.
- Synchronize on demand from the Synchronize page.
- Schedule recurring synchronization with a cron entity and a frequency.
- Add missing local content during synchronization.
- Update changed local content during synchronization.
- Remove orphaned local content whose source record disappeared.
- Get synchronization statistics (missing, different, orphaned counts) before committing.
- Inspect an external entity type's field-to-source mapping in a table.
- Spot unmapped Drupal fields or raw source fields with no mapping.
- Load every entity of a type as a health check via batch.
- Save every external entity in bulk (e.g. mass conversion with xnttmulti).
- Add missing annotation content to annotatable external entities in bulk.
- Export an external entity type's definition, fields and displays as YAML.
- Import an external entity type from a previously exported YAML file.
- Check field-config integrity and auto-fix drifted dependencies.
- Aggregate data from multiple sources (xnttmulti) into one local content type.
- Publish external data through a normal Drupal editorial/review workflow.
- Restrict all of the above to trusted administrators via one permission.
