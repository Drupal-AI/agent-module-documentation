<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `soundcloud` media source plugin

Class `Drupal\media_entity_soundcloud\Plugin\media\Source\Soundcloud` extends `MediaSourceBase`.

```
@MediaSource(
  id = "soundcloud",
  label = "Soundcloud",
  allowed_field_types = {"string", "string_long", "link"},
  default_thumbnail_filename = "soundcloud.png",
  forms = { "media_library_add" = SoundcloudForm },
)
```

The source field stores a SoundCloud URL (track or playlist page). All metadata is derived by
requesting SoundCloud's public **oEmbed** endpoint.

## Metadata attributes (`getMetadataAttributes()`)

| Attribute | Value |
|---|---|
| `track_id` | Numeric track id (only when the URL is a track). |
| `playlist_id` | Numeric playlist/set id (only when the URL is a playlist). |
| `source_id` | `tracks/{id}` or `playlists/{id}` — unique across all SoundCloud media; used by the embed formatter. |
| `html` | The raw oEmbed embed HTML. |
| `thumbnail_uri` | Local URI of the downloaded thumbnail (see below). |

Use them as tokens/mappings on the media type (e.g. map `thumbnail_uri` to the thumbnail, or a
name field). Programmatically: `$media->getSource()->getMetadata($media, 'source_id')`.

## How metadata is resolved (`getMetadata()`)

1. `getMediaUrl()` reads the SoundCloud URL from the source field (main property).
2. `oEmbed($url)` GETs `https://soundcloud.com/oembed?format=json&url=<url>` via `http_client`,
   JSON-decodes it, and statically caches per-URL (`drupal_static`). On a Guzzle `ClientException`
   it returns FALSE (so metadata becomes FALSE / falls back to the default thumbnail).
3. `track_id` / `playlist_id` / `source_id` are parsed out of the oEmbed `html` with regexes:
   `src="([^"]+)"` then `#/(tracks|playlists)/(\d+)#`.
4. `thumbnail_uri`: if the oEmbed data has a `thumbnail_url`, the image is fetched with
   `file_get_contents()` and saved into `media_entity_soundcloud.settings:thumbnail_destination`
   (default `public://soundcloud`), reusing the file if it already exists.

Note: metadata resolution makes **live outbound HTTP requests** to soundcloud.com; without network
access (or for an invalid URL) `getMetadata()` returns FALSE.

## Media Library add form

`SoundcloudForm` (extends `AddFormBase`, form id `soundcloud_media_add_form`) renders a single
"Add Soundcloud Track URL" textfield; `validateSoundcloudUrl()` requires the URL to match
`https?://(www\.)?soundcloud\.com/...` and be reachable, then creates the media item.
