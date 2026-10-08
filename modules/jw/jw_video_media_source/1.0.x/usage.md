<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JW Video Media Source lets editors add JW Player videos as media entities via the Media Library.

---

The module registers a `media` source plugin plus a Media Library form so an editor enters a JW Player media id; a `MediaFetcher` service then calls the fixed JW CDN endpoint (`https://cdn.jwplayer.com/v2/media/{id}`) over the default (TLS-verified) Guzzle client, caches the response, downloads the thumbnail returned by JW, and populates video metadata (title, description, duration, dimensions, MP4 source URL). Adding videos requires media-create privileges, so it is an editorial feature rather than a public endpoint.

---

- Embed JW Player hosted videos as Drupal media entities.
- Pick JW videos through the Media Library UI.
- Store a JW media id as the media source field.
- Fetch video metadata from the JW Player CDN.
- Cache JW API responses to avoid repeat requests.
- Download and store JW video thumbnails locally.
- Render JW videos with a dedicated field formatter.
- Expose title, description, and duration as media fields.
- Select MP4 source and dimensions from the JW playlist.
- Provide a reusable media type for editorial teams.
- Integrate JW video into Layout Builder / node content.
- Reuse videos across the site via the media library.
- Require media-create access to add new videos.
- Support Drupal 8, 9, and 10.
- Keep video hosting/streaming on JW's platform.
- Standardize JW embeds instead of raw markup.
