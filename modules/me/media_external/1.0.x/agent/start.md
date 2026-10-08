# Media External (media_external) — agent index

Media source that imports images from external providers (Pexels + Unsplash ship built-in) via a Media
Library keyword search. Defines a plugin type for adding providers. Depends on core `media` + `media_library`
and contrib `imagecache_external`. No admin settings page (`configure` null), no permissions, no Drush, no
config schema.

- **The `media_external_provider` plugin type: interface, annotation, how to add a provider** →
  [plugins/provider.md](plugins/provider.md)
- **Creating a media type on the External source, source config, metadata mapping, API keys** →
  [configure/media-type.md](configure/media-type.md)

Key facts:
- Media source plugin `external_media` (`Plugin/media/Source/ExternalMedia.php`), `allowed_field_types =
  {string}`; source field stores the external image **ID**.
- Plugin manager service `plugin.manager.media_external_provider` (`ExternalMediaProviderManager`); providers
  live in `Plugin/media/ExternalMediaProvider/`, annotation `@ExternalMediaProvider(id,label)`, interface
  `ExternalMediaProviderInterface` (`search`, `load`).
- Search route `media_external.search` (`/media-library/external/search/{provider_name}/{keyword}`), access
  `media_library.ui_builder:checkAccess`; results cached via `media_external.cache.wrapper`.
- API keys read from settings only: `media.external_provider.pexels.api_key`,
  `media.external_provider.unsplash.access_key`.
