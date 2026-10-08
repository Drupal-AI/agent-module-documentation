<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Resumable Upload (file_resup) — agent index

Chunked, resumable, drag-and-drop uploading layered onto core `managed_file` file-field
widgets. Enabled per field (third-party settings), no new field type. Depends on core `file`.
Global settings page at `file_resup.settings` (`/admin/config/system/file-resup-settings`,
perm `administer file resup`). Provides a config schema; no plugins, no Drush.

- **Enable it on a field, the per-field + global settings, chunk size, config keys** →
  [configure/settings.md](configure/settings.md)
- **The upload wire protocol, `resup_file_id` format, JS flow, and how a chunked upload is
  assembled into a real `file` entity (executable-rename, validators)** →
  [api/upload-protocol.md](api/upload-protocol.md)

Submodule (own docs):
- `file_resup_media_library` (Media Library add-form support) →
  [../../modules/file_resup_media_library/2.0.x/agent/start.md](../../modules/file_resup_media_library/2.0.x/agent/start.md)

Key facts:
- Attaches via `hook_field_widget_complete_form_alter`; only active when the field's
  `file_resup` third-party setting `enabled === 1`.
- Upload route `file_resup.upload` (`file-resup/upload`) is gated only by `_permission:
  'access content'` (anonymous by default). GET initialises/reports progress; POST appends a chunk.
- In-progress uploads tracked by the internal `file_resup` content entity and stored as a temp
  file at `<scheme>://file_resup_temporary/<upload_id>` (`.htaccess` deny written on init).
- Default chunk size 2 MB (`FILE_RESUP_DEFAULT_CHUNKSIZE`), overridable via
  `file_resup.default_chunk_size` config (no UI, no config/install default).
- Permission `administer file resup` (`restrict access: true`) gates the settings form only.
