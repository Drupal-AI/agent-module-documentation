Remote Audio adds a "Remote audio" media source and media type to Drupal core's Media module so editors can embed streaming audio from SoundCloud, Spotify, and iHeartRadio by pasting an oEmbed URL.

---

The module is a thin extension of core Media's oEmbed support. Via `hook_media_source_info_alter()` it registers a new `oembed:audio` media source (reusing core's `OEmbed` source class and the metadata attributes of `oembed:video`) whose allowed providers are iHeartRadio, SoundCloud, and Spotify. Its `config/optional` ships a ready-to-use `remote_audio` media type with an "Audio URL" string field (`field_media_oembed_audio`), plus form/view displays that use core's "oEmbed URL" widget and "oEmbed content" formatter. Because SoundCloud returns quirky oEmbed XML (hyphenated keys and often no thumbnail dimensions), the module registers a `MediaRemoteAudioServiceProvider` that swaps core's `media.oembed.resource_fetcher` service for a `SoundCloudAwareResourceFetcher` subclass, which normalises the keys and derives or defaults the thumbnail size. The module has no settings form (`configure` is null), no permissions, no Drush commands, and no plugin types of its own; it only depends on core `media` (and optionally `media_library` for the add form). Editors add content at `/media/add/remote_audio` by pasting a provider URL, and everything else is standard core Media behaviour.

---

- Embed a SoundCloud track or playlist as a reusable Media entity.
- Embed a Spotify track, album, or podcast episode by pasting its share URL.
- Embed an iHeartRadio station or episode as remote audio.
- Give editors a "Remote audio" option in the Media Library alongside Remote video.
- Create a podcast-episode content type that references remote audio media.
- Reference streaming audio from an article without downloading or hosting the file.
- Reuse a single audio media entity across many nodes.
- Present a consistent audio player using core's oEmbed content formatter.
- Let editors paste an audio URL and have Drupal fetch the provider's embed markup.
- Auto-populate the media name from the provider's oEmbed title metadata.
- Fetch and store provider thumbnail images for audio media (with SoundCloud fallback sizing).
- Add remote audio to a Layout Builder layout via a media field.
- Expose remote audio in a View of media entities.
- Restrict which providers are allowed by editing the media type's source configuration.
- Add remote audio to a WYSIWYG through core's media embed button.
- Standardise audio embedding across a multisite on three streaming providers.
- Avoid a custom media source plugin just to support audio oEmbed.
- Translate the remote audio URL field per language (the field is translatable).
- Use remote audio media as an entity-reference target from any content type.
- Migrate legacy audio links into structured media entities.
- Provide accessible audio playback through the provider's own embed iframe.
- Keep audio storage off-site while managing metadata locally in Drupal.
- Add a "Listen" media field to event or profile content.
- Work around SoundCloud oEmbed responses that omit thumbnail width/height.
- Extend the allowed provider list by altering the `oembed:audio` media source definition.
