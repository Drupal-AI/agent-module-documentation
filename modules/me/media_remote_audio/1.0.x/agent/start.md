# Remote Audio — agent index

Registers an `oembed:audio` **media source** and a ready-made `remote_audio` **media type**
so editors embed SoundCloud / Spotify / iHeartRadio audio by pasting an oEmbed URL. No
settings form (`configure` = null), no permissions, no Drush, no plugin types. Depends on
core `media` (optionally `media_library`).

- **The remote_audio media type, its source field, providers, and how to add/create audio** →
  [configure/remote-audio.md](configure/remote-audio.md)
- **How the source and the SoundCloud fetcher override work (hooks + service provider)** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Media type id `remote_audio`, source plugin id `oembed:audio` (class `\Drupal\media\Plugin\media\Source\OEmbed`).
- Source field `field_media_oembed_audio` (a core `string` field, max 255), widget "oEmbed URL", formatter "oEmbed content".
- Allowed providers: `iHeartRadio`, `SoundCloud`, `Spotify`. Add content at `/media/add/remote_audio`.
- `MediaRemoteAudioServiceProvider` swaps `media.oembed.resource_fetcher` for `SoundCloudAwareResourceFetcher`.
