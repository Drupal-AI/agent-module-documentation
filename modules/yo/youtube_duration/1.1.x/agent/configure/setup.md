# Youtube duration — setup and service

## Enable per media type

Prerequisites: a Media type whose source is **oEmbed (Video)** (`oembed:video`) that already has a
**Duration** field (from the `duration_field` module) added to it.

`youtube_duration_form_media_type_edit_form_alter()` adds a "Youtube duration settings" group to the
media-type edit form **only** when the source is `oembed:video` and at least one `duration`-type field
exists. Fields (saved as third-party settings via an `#entity_builders` callback):

| Setting | Form element | Meaning |
|---|---|---|
| `duration_enabled` | checkbox | Turn the feature on for this media type. |
| `duration_field` | select | Which Duration field to populate (options = the type's `duration` fields). |
| `duration_apikey` | password | YouTube Data API v3 key. |

Schema: `media.type.*.third_party.youtube_duration` (`config/schema/youtube_duration.schema.yml`).
There is no standalone config page; configuration is entirely on the media-type edit form. Unchecking
`duration_enabled` unsets the settings.

## Runtime behavior

`youtube_duration_media_presave()` fires on every media save; for `oembed:video` media it calls
`YoutubeDurationGetterService::initDurationGetter($media_type, $entity)`. That service
(`youtube_duration.duration_getter`, args `@http_client, @duration_field.service,
@media.oembed.url_resolver, @messenger`):

1. Returns early unless `duration_enabled`.
2. Resolves the oEmbed provider from the source-field URL; proceeds only if provider is **YouTube**.
3. Runs only when the source URL changed vs `$entity->original` **or** the duration field is empty.
4. Extracts the video id: `watch?v=<id>`, or the trailing path segment of `youtu.be/<id>` /
   `youtube.com/shorts/<id>`.
5. `GET https://www.googleapis.com/youtube/v3/videos?id=<id>&part=contentDetails&key=<apikey>`; reads
   `items[0].contentDetails.duration` (ISO 8601, e.g. `PT5M33S`).
6. Writes `->duration` (the ISO string) and `->seconds` (via `DurationService::getSecondsFromDurationString`)
   onto the configured field.

Errors: a Guzzle `ClientException` is caught and shown as a messenger error with the API's error
message; oEmbed `ResourceException` aborts silently.

## Notes

- Get an API key from the Google Cloud console with the "YouTube Data API v3" enabled.
- The key is stored per media type as a third-party config setting (standard Drupal config;
  override via `settings.php` `$config[...]` or environment if you prefer to keep it out of exports).
