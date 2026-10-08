<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Registered via `drush.services.yml` → `Commands\ImportCommand` (uses `Service\ImportManager`).

- `drush localgov_publications_importer:import` (alias **`lpii`**) — process the pending-import queue now. Use this when cron processing is disabled (Settings → "Process imports on cron" unchecked), or to force a run.

Related settings (`localgov_publications_importer.settings`, form at `/admin/config/system/localgov-publications-importer`, perm `administer imports`):
- `cron_processing_mode` (bool) — when on, cron processes pending imports.
- `cron_items_limit` (int, default 1) — max imports processed per cron run.

Typical workflow:
```
drush en localgov_publications_importer -y
# create at least one localgov_import_pipeline (UI: /admin/config/system/... → Import Pipelines)
# upload a PDF at /admin/content/imports/create
drush lpii        # process now, or wait for cron
```
