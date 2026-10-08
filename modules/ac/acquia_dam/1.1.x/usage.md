<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia DAM integrates the Acquia DAM (Widen) digital-asset-management SaaS with Drupal, exposing remote assets as Drupal media entities through a media source plugin, with OAuth authentication, embedding, metadata mapping, and optional local download/sync.

---

The module ships a media source plugin `acquia_dam_asset` with a derivative per asset kind, installing eight media types out of the box: Image, Video, Audio, PDF, Documents, Archive, SpinSet, and Generic. Editors browse and embed DAM assets through the core Media Library (a remote-data view, `acquia_dam_asset_library`, powered by `views_remote_data`), and assets can either be embedded by reference or downloaded and synced locally (controlled per media type by the source's `download_assets` setting). Authentication is OAuth against a configured DAM `domain`: a site-level connection plus per-user authorization, stored in `acquia_dam.settings` (with the client secret held in a Key entity via `key_id`). Admin forms under `/admin/config/acquia-dam` cover the main connection, metadata handling (which DAM metadata fields may be mapped onto media types), image styles, and integration links. Rendering options include embed-code formatters, responsive image and thumbnail formatters, and a custom stream wrapper for asset files. Background upkeep is handled by cron, a queue, an "asset update check" action, and a rich set of Drush commands for downloading, updating, metadata-syncing, and (via submodules) importing and integration-link registration. Two submodules extend it: **acquia_dam_integration_links** (deep discovery of asset usage across entity references, paragraphs, and text embeds) and **acquiadam_asset_import** (bulk import of assets by Widen category/asset group). Because it talks to a external SaaS, most runtime behavior requires valid DAM credentials; the Drupal-side configuration (media types, settings, views, image-style and metadata config) exists and is inspectable without a live connection.

---

- Expose Acquia DAM (Widen) images as Drupal media entities editors can reuse across the site.
- Let content authors browse and embed DAM assets straight from the core Media Library.
- Reference DAM assets remotely (no local copy) to keep a single source of truth in the DAM.
- Download and sync selected DAM assets locally per media type via the `download_assets` source setting.
- Provide distinct media types for images, video, audio, PDFs, documents, archives, spinsets, and generic assets.
- Authenticate the site to a DAM domain with OAuth and store the client secret in a Key entity.
- Require each editor to authorize their own DAM account before browsing assets.
- Embed a DAM video or image with an embed-code formatter that pulls the right rendition.
- Serve DAM images through Drupal image styles or responsive image styles.
- Map DAM asset metadata (e.g. description, keywords) onto Drupal media fields via the metadata form.
- Keep embedded assets fresh with the asset update check action and update queue.
- Warn editors when a referenced asset has a newer version or has expired.
- Filter the DAM asset library view by metadata using the module's Views metadata filters.
- Register integration links back to the DAM so asset usage is tracked in Widen.
- Track DAM assets embedded deep in paragraphs and WYSIWYG text (with the integration-links submodule).
- Bulk-import all assets from chosen Widen categories into media entities (with the bulk-import submodule).
- Run scheduled asset metadata sync with `drush acquia-dam:asset-metadata-sync`.
- Download queued assets in the background with `drush acquia-dam:download-assets`.
- Update local copies of changed assets with `drush acquia-dam:update-assets`.
- Resolve which media type an asset maps to with `drush acquia-dam:resolve-asset-media-type`.
- Configure the local storage directory for downloaded assets with a token pattern.
- Restrict which image styles are offered for DAM image assets.
- Disconnect the site from the DAM cleanly via the disconnect confirm form.
- Insert DAM media into CKEditor content and update media revisions from the editor dialog.
- Sanitize DAM auth data on `drush sql:sanitize` so credentials do not leak into copies.
- Give a role the `authorize with acquia dam` permission to let those users connect their DAM account.
