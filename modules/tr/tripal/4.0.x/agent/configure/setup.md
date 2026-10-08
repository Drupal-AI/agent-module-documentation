<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tripal — setup & operation

## Requirements
PHP 8.2+, PostgreSQL (14-18 tested), and the `pgsql` core module (Chado lives in PostgreSQL). Views, File and Path core modules.

## Enable
Enable `tripal`. For biological data storage also enable `tripal_chado` (pulls `tripal_biodb`) and, for auto layouts, `tripal_layout` (needs `field_group` + `field_group_table`). A `tripaldocker` environment and a Dockerfile ship for reproducible dev/CI.

## Chado
`tripal_chado` prepares/installs a Chado schema in PostgreSQL and connects to it via TripalDBX. Use the admin tooling to install or attach a Chado instance before importing biological data.

## Admin surface (`/admin/tripal`)
- **Dashboard** — status + admin notifications.
- **Jobs** (`tripal.jobs`) — submit/view/cancel/rerun long tasks; run the queue on cron or `drush`.
- **Data Loaders** (`tripal.data_loaders`) — run TripalImporter plugins to bulk-load data.
- **Controlled vocabularies** (`tripal.cv_lookup`) — look up terms and children.
- **File uploads** (`tripal.upload` + `tripal.upload.chunk`) — chunked uploads with per-user quotas (`tripal.files_quota`); promote to permanent with `make files permanent`.
- **Data collections** (`tripal.data_collections`) — build/manage/download collections.

## Permissions
Grant deliberately: `administer tripal` (config), `manage tripal jobs`, `upload files` / `make files permanent` / `admin tripal files` / `manage tripal files`, `manage tripal data collections`, `administer tripal content` / `publish tripal content` / `manage tripal content types`.

## Content
Define Tripal content types (backed by CV terms), then create/publish `tripal_entity` records. Publishing can be done in bulk from Chado via the publish forms.
