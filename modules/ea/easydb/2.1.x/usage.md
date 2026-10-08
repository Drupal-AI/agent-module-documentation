<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
fylr File Picker (easydb) connects Drupal to a fylr / easydb digital asset management system and copies selected files and their metadata into Drupal media entities.

---

The module ships an Entity Browser widget (`Plugin/EntityBrowser/Widget/Easydb`) and a custom `EasydbFile` form element that opens the fylr picker; when the editor confirms a selection, fylr POSTs the files (or download URLs) plus multilingual metadata to `/easydb/import/{eb_uuid}`, handled by `ImportFilesController`. The controller creates/updates `easydb_image` media entities (installing fields for title, caption, description, keywords, copyright and the fylr UID) and maps fylr languages to Drupal languages, creating translations as needed. Cross-origin requests from the fylr server are handled by `EasydbCorsSubscriber`, which reflects only origins derived from the configured `easydb_server_url` / `drupal_base_url`.

The import route is declared `_access: 'TRUE'`, but the controller enforces access itself: it rejects the request unless the current user is authenticated (uid > 0) **and** `eb_uuid` is present in that user's private tempstore `eb_uuid_list` (the token is seeded only when the user opens the entity browser). Admin configuration lives at `/admin/config/media/easydb` (`administer easydb`); using the picker requires `access easydb`. Setup: enter the fylr server URL and credentials, map languages, and add the fylr Entity Browser to a media/entity-reference field.

---

- Connect Drupal to a fylr / easydb DAM instance.
- Configure the fylr server URL and base URL at `/admin/config/media/easydb`.
- Copy selected fylr files into Drupal as `easydb_image` media.
- Import file metadata (title, caption, description, keywords, copyright).
- Store the fylr asset UID on each media entity for re-sync.
- Update an existing media entity when the same fylr UID is re-imported.
- Map fylr languages to Drupal languages for translations.
- Create translated media entities on multilingual sites.
- Add the fylr Entity Browser widget to a media/reference field.
- Open the fylr picker from a content edit form.
- Fetch files via download URL or receive them in the POST body.
- Sanitise imported filenames like a normal Drupal upload.
- Restrict picker use to users with `access easydb`.
- Restrict configuration to `administer easydb`.
- Reflect CORS headers only for the configured fylr origin.
- Remember the fylr window size per user (window preferences).
- Store a target subdirectory for imported files.
- Use the bundled example module for a ready-made article type.
- Localise the UI via the shipped translations (e.g. German).
