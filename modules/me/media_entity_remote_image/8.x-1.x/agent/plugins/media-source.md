# Remote image media source (`remote_image`)

The module's core is a Media source plugin plus a shared HTTP fetcher service. The source turns a
stored URL into a fully-featured media entity; the fetcher retrieves the remote resource to validate
it and (optionally) build a local thumbnail.

## Media source plugin

- Id: **`remote_image`** — class `Plugin/media/Source/RemoteImage.php`, extends
  `Drupal\media\MediaSourceBase`, implements `MediaSourceFieldConstraintsInterface`.
- Annotation `default_thumbnail_filename = "remote-image.png"` (icon copied to the media icon base
  URI on install — see `.install`).
- `allowed_field_types = { "string", "string_long", "link", "remote_image_url" }`. The bundled type
  uses `remote_image_url`; `createSourceField()` forces the source field label to **`Image URL`** and
  `setRequired(TRUE)`.
- Metadata attributes (`getMetadataAttributes()` / `getMetadata()`): `title`, `url`, `alt`,
  `thumbnail_uri`, plus the special `default_name` (basename of the URL path).
- Source-field constraints (`getSourceFieldConstraints()`): `['RemoteImageUrl' => []]` — attaches the
  validation constraint below to the source field.

`getMetadata()` (RemoteImage.php:99) computes a fetchable URL via
`_media_entity_remote_image_get_fetch_url()` and calls
`$this->resourceFetcher->fetchResource($fetch_url)` for every attribute except `default_name`. Core
`Media::prepareSave()` / thumbnail handling calls `getMetadata($media, 'thumbnail_uri')` on **every
media save**, so a save triggers a server-side HTTP GET of the stored URL.

## Bundled media type and source field

- Media type: **`remote_image`** (`config/install/media.type.remote_image.yml`), label "Remote image",
  `source: remote_image`, `queue_thumbnail_downloads: false`.
- Source field: **`field_media_remote_image_url`** (field type `remote_image_url`) —
  `field.storage.media.field_media_remote_image_url` + `field.field.media.remote_image.…`.
- `field_map: { shortcode: name, username: name }` (legacy map; those attribute names are not in
  `getMetadataAttributes()`, so they resolve to `NULL`).
- Default form/view displays ship for the `default` and (optional) `media_library` modes; the `name`
  field is hidden by default (auto-generated from the URL). Update hooks `8001`–`8005` migrate older
  installs (require the source field, add media_library displays, relabel to "Image URL", hide the
  name, set the default thumbnail style).

## Fetcher service

- Service id: **`media.remote_image.resource_fetcher`** →
  `RemoteImage/RemoteImageFetcher.php` (args `@http_client`, `@cache.default`).
- `fetchResource($url)` — GET (`RequestOptions::TIMEOUT => 15`, `Accept: */*`), caches the result in
  `cache.default` under key `media:remote_image_resource:{style}:{url}`, returns a
  `RemoteImageResource` value object (`getUrl/getTitle/getAlt/getThumbnailUri`). When
  `generate_thumbnails` is on it also writes a temporary local preview file from the response body.
  Throws `RemoteImageException` if the response is not image content.
- `validateResource($url)` — GET, throws `RemoteImageException` unless the body is image content
  (`isImageContent()` → `_media_entity_remote_image_get_extension_from_image_data()`, which keys off
  the `Content-Type` / detected MIME or an `<svg` sniff of the first 2 KB).
- Consumers: `RemoteImage::getMetadata()`, `RemoteImageUrlConstraintValidator::validate()`,
  `RemoteImageForm::validateUrl()`.

## Validation constraint

- Constraint id: **`RemoteImageUrl`** — `Plugin/Validation/Constraint/RemoteImageUrlConstraint.php`
  (message: "The URL must resolve to valid image content."), validator
  `RemoteImageUrlConstraintValidator.php`.
- On entity validation it reads each source-field item's `uri`/`value`, skips unchanged URIs on
  existing entities (`isUnchangedExistingUri()`), and otherwise calls
  `$this->resourceFetcher->validateResource(_media_entity_remote_image_get_fetch_url($uri))`. A failed
  fetch adds a violation at `{delta}.uri`.

## Media Library integration

`hook_media_source_info_alter()` registers `Form\RemoteImageForm` as the `media_library_add` form for
the `remote_image` source. `RemoteImageForm` (extends `media_library\Form\AddFormBase`, form id
`media_library_add_form_remote_image`) shows a single URL input; `validateUrl()` calls
`fetchResource($this->getFetchUrl($url))` before the media entity is created.

## Internal vs external URLs

The source field is a link field. When its `link_type` allows internal links, a value may be stored
as `internal:/path`. `_media_entity_remote_image_get_fetch_url()` /
`_media_entity_remote_image_get_internal_url()` resolve `internal:` values to an absolute URL on the
site's own base host before fetching or rendering. External values are used verbatim.
