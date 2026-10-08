<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — dkan_dataset_archiver.settings

Install: `drush en dkan_dataset_archiver` (needs a working DKAN stack — `dkan`, `dkan_metastore`,
`dkan_metastore_search`, `dkan_common`). Configure at **`/admin/dkan/archiver`** (route
`dkan_dataset_archiver.settings`, form `Form/ArchiverSettings`, permission
**`administer dkan dataset archiver settings`**). Editable config object:
**`dkan_dataset_archiver.settings`** (schema `config/schema/dkan_dataset_archiver.schema.yml`, install
defaults `config/install/dkan_dataset_archiver.settings.yml`).

## Keys (type — meaning; install default)

- `archive` (string `'1'`/`'0'` — master on/off; **`'1'`**). Note this is a string; most code compares
  `=== '1'`.
- `archive_by_theme` (bool — build per-theme aggregates; **false**).
- `archive_by_keyword` (bool — build per-keyword aggregates; **false**).
- `create_annual_archives` (bool — build year-end annual bundles; **false**).
- `skip_annual_all_archive` (bool — skip the single "annual ALL datasets" bundle but keep per-term
  annuals; **false**).
- `create_current_download` (bool — maintain a rolling "current" zip per group; **true**).
- `archive_private` (string — where private-dataset archives go: `'0'` do not archive private,
  `'in_public'` separate sub-dir inside public files, `'in_private'` Drupal private stream; **`'0'`**).
- `treat_as_private` (string — which `accessLevel`s count as private: `'0'` none, `'non-public'`,
  `'restricted public'`, `'public'` = treat all as private; unset by default). Drives `Util::isConsideredPrivate()`.
- `aggregation_delay` (int minutes, 10–1440 — quiet window after a dataset save before aggregates are
  queued on cron; **10**).
- `storage_locations` (string — `'local'`, `'remote'`, `'local_and_remote'`; **`local`**). `remote`
  options are disabled unless the `dkan_dataset_archiver_remote_storage` submodule is enabled.
- `archive_years_retained` (int, 0–365 — years of archives to keep, 0 = forever; **0**).
- `remote_type` (string — only `'aws:s3'` offered; **`aws:s3`**).
- `remote_address` (string — S3 bucket address, e.g. `s3://my-bucket`; trailing `/ ` trimmed on save;
  **''**).
- `remote_region` (string — AWS region, e.g. `us-east-1`; default shown as `us-east-1`).
- `themes_to_skip` / `keywords_to_skip` / `datasets_to_skip` (text — newline lists; the form dedupes,
  natcase-sorts, and normalises comma/space separators to newlines via `convertSort()`). Consumed by
  `ArchiveService::isBlockedTerm()` / `isBlockedDataset()`.
- `theme_keyword_map` (text — one `Original -> New` remap per line; sanitised by `convertSortArrowFormat()`,
  parsed by `ArchiveService::getMap()`; applied by `getMappedTerm()` so variant labels coalesce).
- `size` (int — schema-defined helper, not set by the form).

## Behaviour notes

- The `in_private` radio is disabled when `private://` is not a valid stream
  (`isPrivateFilesStorageConfigured()` → `StreamWrapperManager::isValidUri('private://')`).
- Most cron/queue/API paths short-circuit unless `archive === '1'` **and** the relevant per-type toggle is
  on (e.g. `create_annual_archives`, `archive_by_theme`). See `ArchiveService::isArchiveUpdateAllowed()`
  and `ArchiveApiController::canShowArchivesBasedOnSettings()`.
- `remote_type` / `remote_address` / `remote_region` are only meaningful with the remote-storage submodule;
  they are stored in this parent object for convenience (see the submodule doc).
