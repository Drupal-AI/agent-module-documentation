Media External adds a media source ("External media") that lets editors search third-party image providers (Pexels and Unsplash ship built-in) from inside the Media Library and import chosen images as local media items, extensible with provider plugins.

---

The module defines a `MediaSource` plugin `external_media` and a custom plugin type,
`media_external_provider` (managed by `ExternalMediaProviderManager`, discovered from
`Plugin/media/ExternalMediaProvider`, annotation `@ExternalMediaProvider`). Two providers ship: `Pexels` and
`Unsplash`; each implements `search(keyword, page)` and `load(id)` against the provider's REST API using an
API key read from `settings.php` (`Settings::get('media.external_provider.pexels.api_key')` /
`...unsplash.access_key`). You create a media type using the "External media" source and pick a provider in
the source configuration; the source auto-creates a `string` source field storing the external image ID and
exposes metadata attributes (provider, title, File URL, description, alt, photographer, photographer URL) you
can map to fields. In the Media Library, the module's `ExternalMediaAddForm` adds a keyword search box; the
`media_external.search` route (access gated by core `media_library.ui_builder:checkAccess`) renders result
thumbnails via `#theme => 'image'`, and selected results are imported. On import/metadata read, the source
downloads the provider's thumbnail server-side (Guzzle) into a configurable `thumbnails_directory` (default
`public://external_thumbnails/[date:custom:Y-m]`) and stores the remote image URL for use with the
`imagecache_external` module. The module has no admin settings page (`configure` null), no permissions of its
own, and no config schema; API keys live only in settings, and result data comes from the provider APIs.

---

- Search Pexels stock photos from inside the Media Library and import them as media.
- Search Unsplash photos from the Media Library and import them as media.
- Create a media type whose source is an external provider (Pexels/Unsplash).
- Store just the external image ID locally while fetching data from the provider API.
- Map provider metadata (File URL, alt, description, photographer) onto media fields.
- Auto-create the source field for the external image ID when the media type is saved.
- Cache external image URLs and reuse them with the imagecache_external module for image styles.
- Download and locally store provider thumbnails for the Media Library grid.
- Configure where thumbnails are stored using a token-enabled directory path.
- Keep provider API keys out of config by reading them from settings.php.
- Add a new stock/image provider by writing a `media_external_provider` plugin.
- Give editors a keyword search UI in the media add form instead of pasting URLs.
- Paginate provider search results within the media library.
- Attribute photographers by mapping the photographer name/URL metadata to fields.
- Let editors override the provider-supplied alt text when needed.
- Standardize on approved stock providers for a content team.
- Populate an image field on nodes via an external-media reference.
- Build a curated media collection sourced from free stock libraries.
- Reduce local storage by keeping full-size images remote and only caching thumbnails.
- Extend to non-image providers by implementing the provider interface (search/load).
