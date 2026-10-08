# Media source plugins

Two `@MediaSource` plugins, both extending the abstract `MediaAvPortalSourceBase`
(`src/Plugin/media/Source/`) and implementing `MediaAvPortalSourceInterface`
(itself extends core `MediaSourceFieldConstraintsInterface`).

| Plugin id | Class | Label | Notes |
|---|---|---|---|
| `media_avportal_photo` | `MediaAvPortalPhotoSource` | Media AV Portal Photo | `thumbnail_alt_metadata_attribute = "thumbnail_alt_value"`; adds `photo_uri` metadata |
| `media_avportal_video` | `MediaAvPortalVideoSource` | Media AV Portal Video | — |

Both declare `allowed_field_types = {"string"}` and `default_thumbnail_filename = "no-thumbnail.png"`.
The **source field stores only the resource ref** (e.g. `I-183993`), not a URL — the widget converts
the pasted URL to a ref on save (see [field-formatters.md](field-formatters.md)).

## Supported URLs and ref extraction

`getSupportedUrlFormats()` (shown to the editor) and `getSupportedUrlPatterns()` (regex → callback
method) drive both widget validation and `transformUrlToReference()`, which loops the patterns and
calls the matching callback to return the bare ref.

**Video** (`MediaAvPortalVideoSource`, ref like `I-\d+`):
- `https://audiovisual.ec.europa.eu/en/video/[REF]`
- `https://ec.europa.eu/avservices/video/player.cfm?sitelang=en&ref=[REF]`

**Photo** (`MediaAvPortalPhotoSource`, ref like `P-038924/00-15`; legacy `~2F` in the URL is decoded to `/`):
- `https://audiovisual.ec.europa.eu/media/photo/[REF]`
- `https://audiovisual.ec.europa.eu/en/album/[album-id]/[REF]`

`transformReferenceToUrl($reference)` does the reverse (rebuilds the first supported URL from a stored
ref) so the widget can pre-fill the full URL when editing.

## Metadata mapping

`getMetadataAttributes()` (base) exposes `title` and `thumbnail_uri`; the photo source adds `photo_uri`.
`getMetadata(MediaInterface $media, $name)` looks the ref up via `media_avportal.client`
(`getResource($ref)`) — if the resource is gone it shows *"The Media resource was not found."* and
returns NULL — then resolves:

| `$name` | Value |
|---|---|
| `default_name` | resource title |
| `title` | `AvPortalResource::getTitle()` (decoded, tag-stripped, truncated to 255 chars) |
| `thumbnail_uri` | local thumbnail URI (downloaded on demand, see below), else the default thumbnail |
| `photo_uri` *(photo)* | `AvPortalResource::getPhotoUri()` = `media_json.HIGH.PATH` |
| `thumbnail_alt_value` *(photo)* | resource title (used as `alt` by the photo formatters) |

### Local thumbnail download

`getLocalThumbnailUri()` → `importRemoteThumbnail()` fetch the remote thumbnail via the client
(`getThumbnail()`) and save it as an **unmanaged** file at
`{thumbnails_directory}/{base64-hash of remote URL}.{ext}` (re-used if already present). The directory
is created/made-writable with `FileSystemInterface::prepareDirectory()`; failures are logged to the
`media` channel and downgrade to the default thumbnail.

## Source-field constraint

`getSourceFieldConstraints()` returns `['avportal_resource' => []]`, wiring the `avportal_resource`
constraint (`AvPortalResourceConstraintValidator`) onto the source field: on save it calls
`getResource($ref)` and adds a violation *"The given URL does not match an AV Portal URL."* when the ref
does not resolve to a real resource (empty value is skipped).

## Per-type source configuration

`defaultConfiguration()` sets `thumbnails_directory` = `public://media_avportal_thumbnails`;
`validateConfigurationForm()` rejects a value that is not a valid stream URI. `prepareFormDisplay()`
forces the source field onto the `avportal_textfield` widget and removes the media `name` field from
the edit form. Config schema: `media.source.media_avportal_video` / `media.source.media_avportal_photo`
(`type: media.source.field_aware`, key `thumbnails_directory`).
