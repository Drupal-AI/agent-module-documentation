Youtube duration fetches a YouTube video's length from the YouTube Data API and writes it into a Duration field on a `oembed:video` media type when the media is saved.

---

The module adds Gatsby-style third-party settings to the media-type edit form (only for media types whose source is `oembed:video` and that already have a `duration` field). There you enable the feature, pick which Duration field to populate, and enter a YouTube Data API key. On `hook_ENTITY_TYPE_presave` for media, `YoutubeDurationGetterService` resolves the oEmbed URL's provider; if it is YouTube and the source value changed or the duration is empty, it extracts the video id (supporting `watch?v=`, `youtu.be/`, and `shorts/` URLs), calls `https://www.googleapis.com/youtube/v3/videos?part=contentDetails` with the API key, and stores the returned ISO 8601 duration string plus its seconds (via the `duration_field` service) into the chosen field. API/connection errors are surfaced as messenger errors. Settings are stored per media type as third-party settings (`duration_enabled`, `duration_field`, `duration_apikey`) with a config schema. Requires core Media and the `duration_field` module (`^2.0`).

---

- Auto-populate a video's runtime on a YouTube media entity when it is created.
- Backfill duration for existing YouTube media whose duration field is empty.
- Refresh the duration automatically when the YouTube URL on a media item changes.
- Store the length as an ISO 8601 duration usable by the Duration Field module.
- Show video length on media/teaser displays without manual data entry.
- Support standard `youtube.com/watch?v=` URLs.
- Support shortened `youtu.be/` URLs.
- Support YouTube Shorts (`/shorts/...`) URLs.
- Populate a Views-exposed duration column for a video library.
- Sort or filter a video listing by runtime.
- Keep durations in sync with the canonical value from YouTube.
- Use a dedicated Duration field of your choice on the media type.
- Enable the feature per media type via the media-type edit form.
- Surface YouTube API errors to editors via Drupal messages.
- Convert the API duration into seconds for numeric comparisons.
- Provide accurate runtimes for playlists or catalog pages.
- Avoid re-querying the API when the URL and duration are unchanged.
