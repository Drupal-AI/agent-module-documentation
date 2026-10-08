<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Youtube Channel (youtubechannel) — agent index

Renders a block listing recent videos from one YouTube channel. On render it calls the
**YouTube Data API v3** to resolve the channel's *uploads* playlist and list its latest
items, then shows the thumbnails; clicking a thumbnail loads that video into an inline
`<iframe>`. No module dependencies (core only); the JS/CSS library depends on `core/jquery`.
Core requirement `^8.9 || ^9 || ^10 || ^11`.

Settings live at `/admin/config/services/youtubechannel` (route `youtubechannel.settings`),
gated by core's `administer site configuration`. The module declares **no permission,
drush command, plugin type, or config schema of its own.**

- **Configure the API key, channel id and video limit** → [configure/settings.md](configure/settings.md)
- **Place / understand the video block and its fetch + render path** → [blocks/youtubechannel-block.md](blocks/youtubechannel-block.md)

Key facts:
- Config object `youtubechannel.settings`, keys: `youtubechannel_api_key`,
  `youtubechannel_id`, `youtubechannel_video_limit` (default 5),
  `youtubechannel_video_width` (default 200), `youtubechannel_video_height` (default 150).
  All five fields are `#required` on the form; there is no `config/install` default and no
  `config/schema`, so the object exists only once the form is first saved.
- Block plugin id `youtubechannel_block` (annotation `@Block`, class
  `src/Plugin/Block/youtubechannelblock.php` → `Youtubechannelblock`, admin label
  "Youtube Channel"). Its `build()` just returns `['#theme' => 'youtubechannel_block']`.
- Theme hook `youtubechannel_block` is registered in `youtubechannel_theme()`
  (`youtubechannel.module`), which **calls the fetch function `youtubechannelvideo()` at
  theme-registry build time** and stores the result as the default `youtube_content`
  variable — so the video list is captured on cache rebuild, not per request.
- The fetch (`youtubechannelvideo()`) makes two `\Drupal::httpClient()->get()` calls to
  `https://www.googleapis.com/youtube/v3/channels?part=contentDetails…` then
  `…/playlistItems?part=snippet…`, passing the API key as the `key` query parameter.
- Template `templates/youtubechannel-block.html.twig`; library
  `youtubechannel/youtubechannel` (`css/youtubechannel.css`, `js/youtubechannel.js`,
  depends `core/jquery`) is attached site-wide by `hook_page_top()`.
- The API key is a server-side Google API key held in `youtubechannel.settings`; per this
  repo's convention keep its value in an environment variable rather than committing it in
  a config export.
- `.info.yml` carries the legacy packaging string `version: '8.x-3.5'` for this `3.5.x` branch.
