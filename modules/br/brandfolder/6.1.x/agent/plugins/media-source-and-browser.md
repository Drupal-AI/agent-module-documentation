<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Brandfolder — media source, browser & fields

## Media source `brandfolder_image`
`src/Plugin/media/Source/BrandfolderImage.php` (`@MediaSource id = "brandfolder_image"`, extends
`MediaSourceBase`, `allowed_field_types = {"string"}`). The source field stores a Brandfolder **attachment ID**.
- `createSourceField()` / `createSourceFieldStorage()` create the string source field; `createImageField()`
  auto-adds a companion Image field so the asset can render via any image formatter (default: standard image
  formatter, configured in `prepareViewDisplay()`).
- `getMetadataAttributes()` / `getMetadata(MediaInterface $media, $attribute_name)` expose Brandfolder metadata
  (name, alt text, dimensions, CDN URL, etc.) for field mapping. `getForcefullyUpdatedMetadataAttributes()` lists
  attributes that are re-pulled even when the mapped Drupal field is non-empty.
- `buildConfigurationForm()` lets each media type restrict itself to Brandfolder collections/sections/labels via
  the Gatekeeper.

Create as many media types as needed (e.g. "Logo", "Product Photo"), each scoped differently.

## Gatekeeper service `brandfolder.gatekeeper`
`src/Service/BrandfolderGatekeeper.php` — the access/query layer for assets. It holds `criteria`
(approved/expired/unpublished + allowed/disallowed collection, section, label, filetype) and validates that a
requested asset/attachment is permitted for the current context. Key methods:
`loadFromMediaSource()`, `loadFromFieldDefinition()`, `loadFromEntityBrowserFileValidators()` (three ways to seed
criteria); `setCriteria()`/`getCriteria()`; `fetchAssets($query_params)`, `fetchAttachmentsById()`;
`getCollections()`, `getSections()`, `getLabels()`; `validateBrandfolderEntities()`. It builds its own
`BrandfolderClient` from `BrandfolderKeyService`.

## Browsers & controllers
- **Entity Browser widget** `brandfolder_browser` (`src/Plugin/EntityBrowser/Widget/BrandfolderBrowser.php`) — used
  by the contrib Entity Browser module; renders the JS browser.
- **Field widgets** — `brandfolder_entity_browser_file` (`BrandfolderFileEntityBrowserWidget`) for File fields and
  `BrandfolderImageBrowserWidget` for the image browser; core Image fields opt in via the field's third-party
  `brandfolder_settings`.
- **Media Library** — `brandfolder_browser_media_library_form_manipulator()` and
  `brandfolder_browser_to_media_library_selection_converter()` (`brandfolder.module`) splice the Brandfolder browser
  into the core Media Library "insert media" dialog.
- **Browser data controller** `BrandfolderBrowserController` (routes `brandfolder.browser_update`,
  `brandfolder.browser_get_attachments`, both `read brandfolder assets`). The JS browser POSTs a `bfBrowserId`
  keyed into `tempstore.shared` (`brandfolder_browser_data`), whose stored `gatekeeper_criteria` bound the query;
  user search text/filters are turned into a Brandfolder search string and passed to `Gatekeeper::fetchAssets()`.
  Responses are `JsonResponse`s of asset/attachment data + a control schema for filters.

## From selection to entities
On "Insert Selected", `brandfolder_map_attachment_to_file()` and `brandfolder_map_attachment_to_media_entity()`
(`brandfolder.module`) create/reuse Drupal `file` + `media` entities and record the mapping in `brandfolder_file`
(fid ↔ bf_attachment_id ↔ bf_asset_id ↔ cdn_id ↔ uri). Reverse lookups: `brandfolder_map_file_to_attachment()`,
`brandfolder_map_media_entity_to_attachment()`. Alt text can be set inline via the AJAX command
`BrandfolderSetAltTextCommand` (`src/Ajax/`).

## Metadata sync (one-way BF → Drupal)
`brandfolder_media_presave()` refreshes mapped metadata according to `metadata_sync_mode`. Alt text specifically is
resolved by `brandfolder_get_alt_text_from_asset()` / `_from_attachment()` using the configured
`alt_text_custom_field`. Webhook-driven sync is covered in [api/client-and-webhook.md](../api/client-and-webhook.md).
