<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block — Youtube Channel

The only user-facing surface. Place it in any region (Block layout, or a block-based theme)
under the admin label **"Youtube Channel"**.

- **Plugin id:** `youtubechannel_block`
- **Class:** `Drupal\youtubechannel\Plugin\Block\Youtubechannelblock`
  (`src/Plugin/Block/youtubechannelblock.php`), annotation `@Block`, extends `BlockBase`.
- **build():** returns `['#theme' => 'youtubechannel_block']` — nothing else. It passes **no**
  `#youtube_content` variable and sets **no** cache metadata, so the rendered content comes
  from the theme hook's default variable value (below), and cache tags/max-age are core
  block defaults only.

## How the video list is fetched and rendered

All logic lives in `youtubechannel.module`; there is no service class.

1. `youtubechannel_theme()` registers the `youtubechannel_block` theme hook. At registration
   time it **calls `youtubechannelvideo()`** and stores its return as the default value of
   the `youtube_content` variable. Because `build()` supplies no override, the videos shown
   are whatever `youtubechannelvideo()` returned **when the theme registry was last built**
   (i.e. on the last cache clear) — this is the module's de-facto cache: no time-based
   expiry, refreshed by `drush cr`.
2. `youtubechannelvideo()` reads `youtubechannel.settings` and does two YouTube Data API v3
   requests via `\Drupal::httpClient()->get()`:
   - **Channel call** — `…/youtube/v3/channels?part=contentDetails&id={youtubechannel_id}&maxResults=1&fields=…relatedPlaylists/uploads&key={api_key}`
     to resolve the channel's *uploads* playlist id.
   - **Playlist call** — `…/youtube/v3/playlistItems?part=snippet&maxResults={youtubechannel_video_limit}&fields=…items/snippet(resourceId/videoId,title,thumbnails/default/url)&playlistId={uploads}&key={api_key}`
     to list the newest items.
   Both calls are wrapped in `try/catch` that swallows `RequestException` /
   `BadResponseException` / `\Exception` (no logging), so an API failure yields an empty/partial
   result rather than an error.
3. For each returned item it keeps `snippet.resourceId.videoId` (used as the list key) and
   `snippet.thumbnails.default.url` (the `<img>` src). The item `title` is read but **not**
   emitted (the line assigning it into the render data is commented out). Width/height are
   wrapped as `['#plain_text' => …]` render arrays.
4. If the channel call returns no items, `youtubechannelvideo()` sets `show_error = true` and
   a `config_link` to the settings route; the template then prints a "please configure" notice.
   If the playlist has zero results it returns the string "No videos available on this channel."

## Template and behaviour

- **Template:** `templates/youtubechannel-block.html.twig`. Renders a `#youtubechannel-player`
  wrapper containing an empty `<iframe id="youtubechannel-frame">`, then a
  `#youtubechannel-list` `<ul>` of thumbnail links — one `<li><a href="#{videoId}"><img
  src="{thumbnail}"></a></li>` per video — plus a "Goto Youtube Channel" link. Values are
  printed through Twig's default HTML auto-escaping.
- **Library:** `youtubechannel/youtubechannel` (`youtubechannel.libraries.yml`) —
  `css/youtubechannel.css` + `js/youtubechannel.js`, depends on `core/jquery`. It is attached
  **site-wide** by `youtubechannel_page_top()` (`hook_page_top`), not just on the block.
- **JS behaviour `Drupal.behaviors.youtubechannel`** (`js/youtubechannel.js`): on attach it
  loads the first thumbnail's video into the iframe (`src` =
  `https://www.youtube.com/embed/{videoId}`) and rebinds each thumbnail click to swap the
  iframe `src`. (The click handler `return FALSE;` is uppercase, so it does not actually
  suppress the default anchor jump — a latent bug, not a feature.)

## Notes for integrators

- There is exactly one block instance's worth of data source; the channel/limit come from
  global config, so every placement of the block shows the same channel.
- To force a refresh after the channel publishes new videos, rebuild caches (`drush cr`);
  the module has no cron hook or scheduled refresh.
