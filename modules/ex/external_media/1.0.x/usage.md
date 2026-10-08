<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
External Media adds field widgets that let editors pick a file straight from Dropbox, Google Drive, OneDrive or Box instead of downloading it to their machine and uploading it again. The picked file is saved as an ordinary managed file on the entity's existing File or Image field.

---

The module defines its own `ExternalMedia` plugin type — one plugin per provider in `src/Plugin/ExternalMedia/` (`Dropbox`, `GoogleDrive`, `OneDrive`, `Box`) over a shared `ExternalMediaBase`, discovered by `ExternalMediaManager` (service `plugin.manager.external_media`) and alterable via `external_media_plugin_info`. Two field widgets — `external_media_file_widget` for `file` fields and `external_media_image_widget` for `image` fields — plus a reusable `external_media` form-element `#type` (extending core `ManagedFile`) expose the picker; each vendor's own JavaScript picker (`js/dropbox.js`, `js/google.js`, `js/onedrive.js`, `js/box.js`) runs the dialog in the browser and posts the chosen file's download reference back in a hidden `external_urls` field. On submit the widget resolves the plugin, calls its `getFile()` to obtain a download URL or raw bytes, saves the result with `file.repository`, and runs the field's upload validators on it. Permissions are generated rather than declared: `ExternalMediaController::permissions()` emits one `upload from <plugin_id>` permission per plugin whose `classExists()` returns true. Settings — per-provider `enabled`, `button_label` and the browser-side app/client IDs — live in State under `external_media.info`, edited at `/admin/config/media/external-media`; there is no config object or config schema. The module targets `^10.6 || ^11.3 || ^12`.

---

- Let editors attach a file from Dropbox without downloading it first.
- Pull an image from Google Drive into an image field.
- Use OneDrive as the source for document uploads.
- Attach a file from Box to a node.
- Avoid round-tripping large files through a laptop.
- Give each cloud provider its own upload permission.
- Enable only the storage services an organisation uses.
- Speed up editorial workflows for large assets.
- Keep source files in a team's existing cloud storage.
- Offer a familiar file picker inside Drupal.
- Restrict Dropbox access to one editorial role.
- Add a provider by writing an `ExternalMedia` plugin.
- Show services as inline buttons or a single dropdown per field.
- Limit which services appear on a specific field via visible-widgets.
- Standardise where an organisation's media originates.
- Configure provider client IDs from one settings page.
- Attach the same cloud file to several nodes.
- Add cloud picker buttons to a custom form via `#type => external_media`.
- Give an image field a cloud-backed widget with an in-form preview.
- Respect file-extension, size and cardinality field settings on picked files.
- Migrate assets gradually from cloud storage into Drupal.
- Present a `Choose file…` split button that reveals enabled services.
- Reduce upload failures on slow connections.
