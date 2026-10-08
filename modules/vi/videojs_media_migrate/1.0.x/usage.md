<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VideoJS Media Migration is a one-purpose migration module that moves legacy `videojs_mediablock` Block Content entities into the newer `videojs_media` content entities.

---

It ships Migrate API configuration (using migrate_plus and migrate_tools) that reads the old block-content records and creates equivalent `videojs_media` entities, so sites upgrading from the block-based VideoJS media approach keep their video content. There is no UI or route — the module exists purely to provide the migration definitions, which are run with Drush (`drush migrate:import`) or the Migrate Tools UI.

Typical use: install alongside the target `videojs_media` module, run the provided migration, verify the created media entities, then remove the legacy blocks. Because it operates only through the Migrate framework and has no HTTP surface, its security posture is limited to the permissions of whoever runs the migration.
---
- Migrate videojs_mediablock blocks to videojs_media entities
- Preserve existing video content during a VideoJS upgrade
- Run the migration via `drush migrate:import`
- Use migrate_tools to manage the migration
- Roll back the migration if needed
- Check migration status before/after import
- Batch-convert many legacy video blocks at once
- Avoid manually recreating video media
- Provide reusable Migrate config for VideoJS content
- Clean up legacy blocks after conversion
- Integrate into a larger site upgrade migration group
- Map old block fields to new media fields
- Preserve video source URLs and settings during conversion
- Re-run the import idempotently for new blocks
- Validate migrated media before decommissioning blocks
- Combine with other migrate_plus migration groups
