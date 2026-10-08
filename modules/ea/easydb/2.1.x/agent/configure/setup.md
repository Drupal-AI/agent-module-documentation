<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# easydb (fylr File Picker) — setup

## Configuration
`/admin/config/media/easydb` (`EasydbSettingsForm`, permission `administer easydb`, config `easydb.settings`). Key settings: `easydb_server_url`, `drupal_base_url`, `easydb_files_subdir`, `language_mapping`. The server URL / base URL also define the allowed CORS origins.

## Media model (installed config)
Media bundle `easydb_image` with fields `field_easydb_title`, `field_easydb_caption`, `field_easydb_description`, `field_easydb_keywords`, `field_easydb_copyright`, `field_easydb_uid` (+ `field_media_image`). An `easydb_entity_browser` Entity Browser and matching view are installed. The `modules/example` submodule adds an `easydb_article` node type wired to the picker.

## Picker flow
`Element/EasydbFile::processManagedFile()` seeds an `eb_uuid` into the user's private tempstore (`easydb` collection, `eb_uuid_list`) and opens the fylr window. On confirm, fylr POSTs to `/easydb/import/{eb_uuid}`.

## Import endpoint (`ImportFilesController::handleRequest`)
Route `_access: 'TRUE'`, but the controller enforces:
1. OPTIONS pre-flight answered with CORS headers (origin must match config).
2. `uid > 0` (authenticated) else 401.
3. `eb_uuid` must be in the user's tempstore `eb_uuid_list` else 401.
Then for each file it either reads the multipart POST body or cURL-fetches `file_metadata['url']`, saves a managed file, and creates/updates the `easydb_image` media (with translations per `language_mapping`). Created media ids are stored in tempstore key `mids_<eb_uuid>` for the entity browser to pick up.

## Permissions
- `access easydb` — use the picker widget.
- `administer easydb` — configuration form.
