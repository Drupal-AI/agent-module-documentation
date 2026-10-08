# Media External — media type setup & source config

## API keys (settings.php)
Keys are read only from Drupal settings (never stored in config/UI):
```php
$settings['media.external_provider.pexels.api_key']    = 'YOUR_PEXELS_API_KEY';
$settings['media.external_provider.unsplash.access_key'] = 'YOUR_UNSPLASH_ACCESS_KEY';
```

## Create the media type
1. *Structure → Media types → Add media type.* Choose **External media** as the media source.
2. In the source configuration set:
   - **Provider** (`provider`) — select `pexels` / `unsplash` (or a custom provider plugin).
   - **Thumbnails location** (`thumbnails_directory`) — a stream-wrapper URI, tokens allowed. Default
     `public://external_thumbnails/[date:custom:Y-m]`. Validated with `streamWrapperManager->isValidUri()`.
3. Save. The source **auto-creates a `string` source field** ("<label> ID") that stores the external image
   ID; the media add form for the field is set to `string_textfield` and the name component removed.

## Metadata attributes (map to fields)
`ExternalMedia` source exposes these metadata attributes (`getMetadataAttributes()`), resolvable per media
item via `getMetadata()`:
`provider`, `title` (basename of the file URL), `url` (**File URL**), `description`, `alt`, `photographer`,
`photographer_url`, plus `thumbnail_uri`. Map **File URL** and **Alt text** to dedicated text fields (README
recommendation) so values persist without re-hitting the API; combine the URL field with `imagecache_external`
to apply image styles.

## Importing images (editor flow)
- In a Media Library field / the media add page for this type, `ExternalMediaAddForm` shows an **Add by
  keyword** box + Search (AJAX). Results come from `media_external.search`
  (`/media-library/external/search/{provider_name}/{keyword}`), access gated by
  `media_library.ui_builder:checkAccess` (i.e. users who can use the Media Library). Select thumbnails →
  **Import**.
- On import/metadata read, `getLocalThumbnailUri()` downloads the provider thumbnail via Guzzle into the
  thumbnails directory (filename = `Crypt::hashBase64(url)` + extension inferred from URL/Content-Type) and
  the remote full-size `url` is stored for display.

## Notes
- No admin settings page (`configure` null), no permissions, no config schema. The provider list is populated
  from `media_external_provider` plugin definitions (see plugins/provider.md).
- Imported "URLs" are the image URLs returned by the provider's own API for the selected result (not
  free-form editor input); thumbnails are fetched server-side and rendered with core `#theme => 'image'`.
