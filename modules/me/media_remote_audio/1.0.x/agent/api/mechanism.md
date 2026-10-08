# How it works (source alter + fetcher override)

Two pieces of code, no plugin classes of the module's own.

## 1. `hook_media_source_info_alter()` defines `oembed:audio`

In `media_remote_audio.module`, `media_remote_audio_media_source_info_alter(&$definitions)`
adds a new media source by copying core's `oembed:video` definition and overriding fields:

```php
$base = $definitions['oembed:video'];
$definitions['oembed:audio'] = [
  'id' => 'oembed:audio',
  'label' => t('Remote audio'),
  'allowed_field_types' => ['string'],
  'default_thumbnail_filename' => 'no-thumbnail.png',
  'thumbnail_uri_metadata_attribute'    => $base['thumbnail_uri_metadata_attribute'],
  'thumbnail_width_metadata_attribute'  => $base['thumbnail_width_metadata_attribute'],
  'thumbnail_height_metadata_attribute' => $base['thumbnail_height_metadata_attribute'],
  'thumbnail_alt_metadata_attribute' => 'title',
  'providers' => ['iHeartRadio', 'SoundCloud', 'Spotify'],
  'class' => \Drupal\media\Plugin\media\Source\OEmbed::class,
  'provider' => 'media_remote_audio',
];
```

If `media_library` is enabled it also copies the video source's `media_library_add` form so
the type works inside the Media Library. **To change the allowed providers**, implement your
own `hook_media_source_info_alter()` and edit `$definitions['oembed:audio']['providers']`.

## 2. Service override for SoundCloud quirks

`MediaRemoteAudioServiceProvider::alter()` (in `src/`) rewrites the class of the core
`media.oembed.resource_fetcher` service to `SoundCloudAwareResourceFetcher` (extends core
`\Drupal\media\OEmbed\ResourceFetcher`). Its `parseResourceXml()`:

- Detects `provider-name === 'SoundCloud'` and rewrites hyphenated keys to underscores
  (`thumbnail-url` → `thumbnail_url`), because core expects underscored keys.
- If SoundCloud omits thumbnail dimensions, it parses them from a `…500x500.jpg`-style URL,
  else falls back to `200 × 200` — core otherwise rejects a thumbnail with unknown size.

This is a container alter, so the two empty `post_update` hooks
(`media_remote_audio_post_update_*`) exist only to force a container rebuild on update.

## Extending

The module has no services, hooks, or plugin types to implement against. Point of extension
is the source-info alter above; storage/formatting is entirely core Media + core oEmbed.
