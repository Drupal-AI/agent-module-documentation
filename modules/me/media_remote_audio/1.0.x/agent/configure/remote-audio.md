# Using the Remote audio media type

There is **no settings form** — enabling the module installs everything from
`config/optional`. Enabling `media` (and ideally `media_library`) before/with it makes the
optional config install automatically.

## What ships

- **Media type** `remote_audio` (`media.type.remote_audio`): label "Remote audio", source
  `oembed:audio`, `queue_thumbnail_downloads: false`, thumbnails in
  `public://oembed_thumbnails`.
- **Source field** `field_media_oembed_audio` — a core `string` field (storage
  `field.storage.media.field_media_oembed_audio`, `max_length: 255`, translatable,
  cardinality 1), label "Audio URL", **required**.
- **Form display** uses the core **oEmbed URL** widget (`oembed_textfield`).
- **View display** (`default` + `media_library`) uses the core **oEmbed content** formatter.
- **field_map**: the source's `default_name` metadata sets the media name.

## Add / create audio

- UI: `/media/add/remote_audio`, paste a URL from Spotify, SoundCloud, or iHeartRadio, save.
- Media Library: the type appears as "Remote audio" in the add menu when `media_library` is on.
- Programmatically:
  ```php
  $media = \Drupal::entityTypeManager()->getStorage('media')->create([
    'bundle' => 'remote_audio',
    'field_media_oembed_audio' => 'https://soundcloud.com/…',
  ]);
  $media->save();
  ```

## Restrict allowed providers

Providers are validated against the source definition's `providers`
(`iHeartRadio`, `SoundCloud`, `Spotify`). To narrow them per media type, set the media type's
`source_configuration.providers` (empty `{}` means "all allowed by the source"). To change the
global provider list itself, alter the source definition — see
[../api/mechanism.md](../api/mechanism.md).

## Notes

- oEmbed fetching needs outbound HTTP; a URL from an unsupported provider fails validation.
- Thumbnails are downloaded to `public://oembed_thumbnails`; SoundCloud items without
  thumbnail dimensions still work (see the fetcher override).
