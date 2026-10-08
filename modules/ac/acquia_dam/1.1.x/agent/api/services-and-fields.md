<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, fields & rendering

## Key services (`acquia_dam.services.yml`)

| Service | Role |
|---|---|
| `acquia_dam.client.factory` | Builds the authenticated DAM (Widen) API client. |
| `acquia_dam.authentication_service` | Site + per-user OAuth handshake and token storage. |
| `acquia_dam.site_authenticated_access_check` | Route access check `_acquia_dam_site_authenticated_access_check`. |
| `acquia_dam.asset_repository` | Fetch/lookup assets from the DAM. |
| `acquia_dam.media_type_resolver` | Map a DAM asset to the right local media type. |
| `acquia_dam.asset_updater` / `acquia_dam.asset_update_checker` | Detect and apply newer asset versions. |
| `acquia_dam.asset_version_resolver` | Resolve the version of an embedded asset. |
| `acquia_dam.asset_file_helper` / `acquia_dam.file_url_generator` | Local file handling + URLs for assets. |
| `acquia_dam.asset_library_builder` | Builds the Media Library UI for DAM (also provides route access callbacks). |
| `acquia_dam.integration_link_register` | Registers asset-usage integration links with the DAM (foundation the integration-links submodule builds on). |
| `stream_wrapper.acquia_dam` | `acquia-dam://` stream wrapper for asset files. |
| `acquia_dam.cron` | Scheduled asset upkeep. |
| `plugin.manager.acquia_dam.asset_media_source` | Manager for the `AssetMediaSource` plugin type (see plugins doc). |

```php
$client = \Drupal::service('acquia_dam.client.factory')->getSiteClient(); // needs a live connection
$type   = \Drupal::service('acquia_dam.media_type_resolver')->resolve($asset);
```

## Field plugins (`src/Plugin/Field/`)

**Field types:** `AssetItem` / `acquia_dam_asset` (`AssetFieldType`), `ImageFieldType`, plus a
computed `ComputedEmbedCodes` and item lists (`AssetFieldItemList`, `ImageFieldItemList`).

**Formatters:**

| Formatter (settings id) | Renders |
|---|---|
| `acquia_dam_embed_code` | DAM embed code (with `embed_style`, `thumbnail_width`, `image_loading`) |
| `acquia_dam_responsive_image` | responsive image style output |
| `acquia_dam_thumbnail` | asset thumbnail at a chosen `thumbnail_size` |
| `embed_style` | asset reference display in an embed style |
| `EmbedCodeFormatter`, `ResponsiveImageFormatter`, `AssetThumbnailViewer`, `ExpiryDateWarningFormatter`, `AcquiaDamMediaThumbnailFormatter` | corresponding classes |

**Widget:** `entity_reference_revisions_asset_media_library`
(`EntityRevisionAssetMediaLibrary`) and `AssetItemWidget` — the media-library-based asset
picker with an ordered `media_types` allow-list.

## Other plugins

- **Action:** `asset_update_check_action` (`system.action.asset_update_check_action`) — checks
  embedded assets for newer versions; usable as a bulk media action / via the update queue.
- **QueueWorker(s)** under `src/Plugin/QueueWorker/` drive async asset update processing.
- **Filter / CKEditor5 / Linkit** plugins integrate DAM media into text editing and linking.
- **Views:** ships `acquia_dam_asset_library`, `acquia_dam_links`, `dam_content_overview`
  views and remote-data query integration (`acquia_dam.remote_data_query_subscriber`,
  depends on `views_remote_data`), plus metadata Views filters
  (`asset_metadata_string`, `asset_metadata_in_operator`).

## Hooks

`acquia_dam.api.php` documents the alter hooks the module invites (e.g.
`hook_acquia_dam_media_source_alter()` and asset/rendering alters). Token integration lives in
`acquia_dam.tokens.inc` (e.g. `[media:acquia_dam_asset_id:external_id]` used in the download
path).
