<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Orange Logic integrates an Orange Logic (Cortex) digital asset management system with Drupal media, letting editors search the DAM and reference its assets from a media entity browser widget or the media library.

Credentials (API search endpoint, token endpoint, login/credentials) are stored at `/admin/config/media/media-orange-logic` (`MediaOrangeLogicAdminForm`, permission `access administration pages,administer orange logic`). `OrangeLogicManager::search()` builds a criteria query (allowed keys only: MediaType, Text, Artist, Keyword, SystemIdentifier, …), attaches a token from `OrangeLogicTokenManager` (cached in private tempstore), and GETs the configured `search_endpoint`. Results are rendered as thumbnails by `OrangeLogicResultRenderer`. The `OrangeLogicMediaBrowserWidget` entity-browser plugin, the `OrangeLogicMediaSource` media source, an `Orange Logic` field type (stores the full asset payload), and audio/video field formatters wire the DAM into content editing. The `media_orange_logic_samples` submodule ships example media types and an entity browser; `orange_logic_media_library` adds a Media Library source. The module is explicitly self-described as under development.

Security/operational notes: the AJAX route `/media-orange-logic/eb/ajax/selected-assets` (`EntityBrowserController::ajaxSelectedAssets`) is gated only by `_permission: 'access content'` — a permission granted to anonymous by default — and proxies caller-supplied `asset_ids` into a DAM `SystemIdentifier` search using the site's stored token, returning rendered thumbnails/metadata. See the security posture in start.md. Installation requires media_library_extend plus several patches (see the module readme). `OrangeLogicManager::search()` calls `die()` on a Guzzle exception, which will abort the request.
---
Search an Orange Logic (Cortex) DAM and reference its assets from Drupal media via an entity browser or media library.
---
- Store DAM API and token endpoints at `/admin/config/media/media-orange-logic`.
- Grant `administer orange logic` to admins managing DAM credentials.
- Add an entity-reference (media) field to a content type for DAM assets.
- Select the `OrangeLogicMediaBrowser` entity browser on the field's form widget.
- Search the DAM by keyword, artist, media type or system identifier.
- Page through DAM search results via `page_number` / `per_page` options.
- Reference chosen DAM assets as Drupal media entities.
- Add an `Orange Logic` field to a media type to store the full asset payload.
- Render referenced DAM audio with the `OrangeLogicAudio` formatter.
- Render referenced DAM video with the `OrangeLogicVideoFormatter`.
- Enable the `orange_logic_media_library` submodule for a Media Library source.
- Configure a media library pane mapping to fill extra media fields.
- Install `media_orange_logic_samples` for ready-made audio/video media types.
- Retrieve public asset links via `OrangeLogicAssetPublicLinkManager`.
- Obtain and cache an API token through `OrangeLogicTokenManager`.
- Limit search criteria to the API's allowed filter keys.
- Fetch thumbnails for selected assets through the entity-browser AJAX endpoint.
- Review the sample entity browser `orangelogicmediabrowser` config.
