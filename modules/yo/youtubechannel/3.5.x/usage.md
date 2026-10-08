<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Youtube Channel renders a block listing the most recent videos from a single YouTube channel, fetched from the YouTube Data API v3, with clickable thumbnails that load each video into an inline player.

---

The module is deliberately small. A settings form at `/admin/config/services/youtubechannel` collects a Google API key, a channel id (`UC…`), a video limit and the player width/height, all stored in the `youtubechannel.settings` config object. A single block plugin (`youtubechannel_block`) renders the list through the `youtubechannel_block` theme hook and its Twig template, with a stylesheet and a small jQuery behaviour that swaps the iframe source when a thumbnail is clicked. The fetch itself lives in `youtubechannel.module`: `youtubechannelvideo()` makes two YouTube Data API calls — first `channels?part=contentDetails` to resolve the channel's uploads playlist, then `playlistItems?part=snippet` for the videos — passing the API key as a query parameter. One design detail matters operationally: `youtubechannel_theme()` calls the fetch at theme-registry build time and bakes the result into the block's default variable, so the video list is a snapshot refreshed on cache rebuild (`drush cr`) rather than on every request — there is no cron refresh and no time-based expiry. The API key is a server-side Google key; on this repo's convention keep its value in an environment variable and inject it rather than committing it in a config export. The settings route is gated by core's `administer site configuration`; the module defines no permission of its own.

---

- Show a channel's latest videos in a sidebar block.
- Keep a video list current without editing nodes by hand.
- Display a brand's YouTube uploads on the homepage.
- Let visitors click a thumbnail to play a video inline.
- Link visitors to the channel's newest content.
- Limit how many videos the block shows.
- Set the player width and height in pixels.
- Theme the video list with a Twig template override.
- Add channel videos to a landing page region.
- Avoid embedding each video by hand.
- Show a conference channel's talk recordings.
- Surface a training channel inside an intranet.
- Restrict video-block configuration to site administrators.
- Fetch videos through the official YouTube Data API v3.
- Style thumbnails with the supplied CSS.
- Present a channel feed alongside site content.
- Replace a manually curated video list.
- Show uploads from a partner's channel.
- Give editors a zero-maintenance video block.
- Refresh the shown videos on the next cache rebuild.
- Point the block at any channel by its `UC…` id.
- Support a site still on Drupal 9.
