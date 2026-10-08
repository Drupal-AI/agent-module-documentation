<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Resup Media Library (file_resup_media_library) — agent index

Glue submodule: extends parent **file_resup**'s resumable/chunked upload to core's Media
Library "Add media" upload form. Depends on `file_resup`. No config, permissions, schema,
plugins, or Drush of its own.

There are no separate solution docs — all behaviour (chunk protocol, temp storage, validation,
assembly, per-field enable) lives in the parent. See the parent's docs:
- Parent index → [../../../../../file_resup/2.0.x/agent/start.md](../../../../../file_resup/2.0.x/agent/start.md)
- Enable per field + settings → [../../../../../file_resup/2.0.x/agent/configure/settings.md](../../../../../file_resup/2.0.x/agent/configure/settings.md)
- Upload protocol / assembly → [../../../../../file_resup/2.0.x/agent/api/upload-protocol.md](../../../../../file_resup/2.0.x/agent/api/upload-protocol.md)

Key facts:
- Implements `hook_form_media_library_add_form_upload_alter`; only activates when the selected
  media type's **source file field** has file_resup `enabled === 1`.
- `MediaLibraryAddFormUploadAlter` sets `#form_type = 'media_library'`, `#upload_location =
  <uri_scheme>://<Y-m>`, and caps files to `MediaLibraryState::getAvailableSlots()`.
- A `BuildForm` event subscriber answers `BuildFormEvent` for `media_library` by rebuilding
  core `Drupal\media_library\Form\FileUploadForm` from the serialized `media_library` state.
- Uses the same parent `file_resup.upload` (`access content`) endpoint.
