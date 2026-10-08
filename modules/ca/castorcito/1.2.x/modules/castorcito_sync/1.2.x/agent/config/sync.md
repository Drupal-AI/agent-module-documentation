<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Castorcito sync — export & import

## Install & enable

```bash
drush en castorcito_sync -y
```

Requires `castorcito` and core `config`. Menu tabs appear under the Castorcito admin area.

## Export (`CastorcitoSyncExportForm`, `/admin/castorcito/export`)

- Permission: core **`export configuration`**.
- Form: a required `export` radio (`all` / `select`); when `select`, a `components` checkboxes
  element (built from `componentStorage->loadMultiple()` labels). `validateForm()` requires at
  least one component when `select` is chosen.
- `submitForm()`:
  1. deletes any existing `temporary://config.tar.gz`.
  2. resolves the config names to export:
     - `allExportComponents()` → for every component, `castorcito.component.<id>` and its
       `castorcito.castorcito_category.<category>`.
     - `getExportComponents($cids)` → the selected components + categories, **recursing** into
       `container` / `advanced_container` cfields (`allowed_children` and `head_component`).
  3. reads each config name from `config.storage.export` and writes `"<name>.yml"` into a new
     `ArchiveTar` (`config.tar.gz`, gz) via `addString(...)`.
  4. redirects to `castorcito_sync.export_download`.
- `CastorcitoSyncController::downloadExport()` streams `temporary://config.tar.gz` using core's
  `FileDownloadController` (permission `export configuration`).

## Import (`CastorcitoSyncImportForm`, `/admin/castorcito/import`)

- Permission: **`castorcito_sync import configuration`** (`restrict access: true`).
- Form: a `file` element (`import_tarball`; described as `tar.gz tgz tar.bz2`) + submit.
  `validateForm()` reads the uploaded file from the request and stores its real path.
- `submitForm()`: opens the tarball with `ArchiveTar($path, 'gz')`, and for each entry:
  - `getConfigPrefixFromFilename()` derives the config prefix from the filename (strips `.yml`,
    then the last `.`-segment id),
  - `Yaml::decode()`s the content,
  - `createEntity($prefix, $data)` → `getEntityTypeId($prefix)` matches a `ConfigEntityType`
    whose `getConfigPrefix()` equals the prefix, then loads (`$data['id']`) and field-by-field
    `set()`s an existing entity, or `create()`s a new one, and `save()`s it.
  - Shows a status message on success, or an error with the exception message on failure.

## Notes for operators

- Import runs entirely from the uploaded archive on the current site; grant
  `castorcito_sync import configuration` only to fully trusted administrators, and treat imported
  archives as trusted configuration (import applies the YAML as-is, without a review/diff step).
- Both permissions are `restrict access: true`. The export routes intentionally reuse the core
  `export configuration` permission.
