<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ib_dam_media — agent index

Submodule of **intelligencebank** (`ib_dam`). Wires the IntelligenceBank asset browser into the core
**Media Library**: it adds an "Open IntelligenceBank Browser" button to the media add form, provides a
media **source** plugin for embed assets, and turns a browsed DAM asset into a `media` entity — either
by downloading a local copy or by storing the public IB CDN link. Version **5.2.3**, core `^10.3 || ^11`.

Depends on `drupal:link`, `drupal:media`, `drupal:media_library`, `ib_dam:ib_dam`.

- **Media-type mapping + upload location (config form)** → [configure/media-mapping.md](configure/media-mapping.md)
- **The media source plugin, the asset-browser form/route, media storage** → [api/browser-and-source.md](api/browser-and-source.md)

Key facts:
- Config object `ib_dam_media.settings` (schema `ib_dam_media.schema.yml`): `upload_location`
  (default `public://intelligencebank`), `media_types` (source-type → media-type map).
- Config form route `ib_dam_media.configuration_form` → `/admin/config/services/ib_dam/media`,
  permission `administer intelligencebank configuration`.
- Asset-browser form route `id_dam_media.asset_browser_form` → `/ib-dam-browser` (note the `id_dam`
  spelling in the route id), form `MediaLibraryIbDamBrowserForm`.
- Media source plugin id `ib_dam_embed` (`IbDamEmbedField`, `allowed_field_types = {"link"}`), add-form
  `MediaLibraryIbDamRemoteAssetAddForm`.
- Ships a media type `ib_dam_embed` ("IntelligenceBank Embed") with source field
  `field_media_ib_dam_embed` (config in `config/install/`, browser + view/form displays in `config/optional/`).
- Service `ib_dam_media.media_type_matcher` (`MediaTypeMatcher`); storage handler
  `Drupal\ib_dam_media\AssetStorage\MediaStorage`.

Parent: `../../../5.2.x/agent/start.md`.
