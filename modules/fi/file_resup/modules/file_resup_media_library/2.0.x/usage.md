<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Glue submodule that extends File Resumable Upload's chunked, resumable, drag-and-drop uploading to Drupal core's Media Library "Add media" upload form.

---

`file_resup_media_library` is a thin integration shim over its parent `file_resup`. It implements `hook_form_media_library_add_form_upload_alter` to detect the selected media type, resolve that type's source file field, and — when that field has file_resup enabled (`enabled === 1` third-party setting) — reuse `FileFormAlterBase` to inject the resumable `resup` element into the Media Library upload widget. Its `MediaLibraryAddFormUploadAlter` sets `#form_type = 'media_library'`, computes the upload location as `<uri_scheme>://<Y-m>` (matching how Media Library itself dates upload folders), and limits the number of files to the media field's remaining slots (`MediaLibraryState::getAvailableSlots()`). A dedicated `BuildForm` event subscriber answers the parent's `BuildFormEvent` for `form_type === 'media_library'` by rebuilding core's `Drupal\media_library\Form\FileUploadForm` from the serialized `media_library` state so the upload controller can read the correct validators. All actual chunk transport, temp storage, validation, and file assembly are handled by the parent module and its `file_resup.upload` route. It adds no config, permissions, schema, or Drush of its own.

---

- Add resumable, chunked uploading to the Media Library "Add media" dialog.
- Upload very large media files (video, audio, archives) through Media Library beyond PHP's request limits.
- Resume an interrupted Media Library upload where it left off.
- Drag-and-drop multiple media files into the Media Library add form at once.
- Respect the media field's remaining slots so you can't exceed its cardinality.
- Store Media Library uploads in the source field's scheme under a dated (`Y-m`) folder, as core does.
- Reuse a media type's existing file-field extension and size validators for chunked uploads.
- Enable resumable Media Library uploads only for media types whose source file field opts in.
- Give a consistent large-file upload UX across both entity forms and the Media Library.
- Bring auto-upload / progress-bar behaviour from file_resup into Media Library.
- Upload into an Image, Video, Audio, or Document media type's source field with resume support.
- Avoid re-uploading large media from scratch after a browser refresh mid-upload.
- Keep Media Library uploads flowing through the same `.htaccess`-protected temp directory as file_resup.
- Let editors populate a media reference field with large assets without hitting timeouts.
- Combine Media Library reuse (browse existing media) with resumable creation of new large media.
