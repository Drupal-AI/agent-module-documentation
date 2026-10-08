<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Youtube playlist provides a "Youtube playlist" content entity plus a block that renders the videos of a YouTube playlist/channel by querying the YouTube Data API with an admin-supplied API key.

---

The `YoutubePlaylist` content entity (with a custom HTML route provider and list builder) stores playlist definitions, and the `YoutubePlaylistBlock` block plugin fetches items through `@http_client` from the fixed host `https://www.googleapis.com` (YouTube Data API v3), using the API key configured in the block/settings. A settings form at `/admin/structure/youtube-playlist` (`administer youtube playlist`, restricted) and an entity add/edit form manage playlists; the block config holds the API key and playlist parameters. Results are rendered as a list of videos with thumbnails.

Security review: the API host is a hardcoded HTTPS constant (no request-supplied URL, so no SSRF) and TLS uses Guzzle defaults (not disabled). The API key is admin-entered block/settings config. Admin routes are permission-gated (`administer youtube playlist`, restrict access). Setup: obtain a YouTube Data API key, create a Youtube playlist entity, then place the block and point it at the playlist.

---
- Show a YouTube playlist's videos in a block.
- List a channel's latest videos.
- Configure a YouTube Data API key.
- Create reusable playlist entities.
- Place the playlist block in a region.
- Display video thumbnails and titles.
- Manage playlist definitions via an admin list.
- Add/edit playlists through the entity form.
- Limit the number of videos shown.
- Embed a curated video list on a landing page.
- Restrict playlist administration with a permission.
- Point a block at a specific playlist id.
- Refresh video data from the YouTube API.
- Build a "watch" section from a YouTube channel.
- Theme the playlist output.
- Reuse one playlist entity across multiple blocks.
