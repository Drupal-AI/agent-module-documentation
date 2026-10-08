# Youtube duration — agent index

On media presave, fetches a YouTube video's length from the YouTube Data API and writes it into a
Duration field of an `oembed:video` media type. Depends on core `media` and the `duration_field`
module. No config UI route (`configure` null), no permissions, no Drush. Provides config schema (media
third-party settings).

- **Enabling per media type, the third-party settings, the getter service, and API-key handling** →
  [configure/setup.md](configure/setup.md)

Key facts:
- Config: media-type third-party settings `youtube_duration.{duration_enabled, duration_field,
  duration_apikey}` (schema `media.type.*.third_party.youtube_duration`), added via
  `hook_form_media_type_edit_form_alter`.
- Logic: `hook_media_presave` -> `youtube_duration.duration_getter`
  (`YoutubeDurationGetterService::initDurationGetter`).
- API call: `GET https://www.googleapis.com/youtube/v3/videos?part=contentDetails&id=<id>&key=<key>`;
  stores the ISO 8601 `contentDetails.duration` and its seconds.
