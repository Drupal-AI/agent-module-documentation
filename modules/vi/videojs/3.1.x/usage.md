<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Video.js Player integrates the [Video.js](https://videojs.com/) HTML5 player with Drupal by providing field formatters that render File and Video reference fields as a Video.js `<video>` element, loading the library from a CDN by default.

---

The module ships two field formatters — `videojs_player` (single-value File/Video fields) and `videojs_player_list` (multi-value fields, rendered as one player with multiple `<source>` elements). You select one on an entity's *Manage display* tab for any `file` or `video` field. Each formatter exposes per-display settings: `width`, `height`, `controls`, `autoplay`, `loop`, `muted`, and `preload` (none/metadata/auto), stored in the display component. The formatter builds a `#theme => 'videojs'` render element whose `templates/videojs.html.twig` emits a `<video class="video-js" data-setup="{}">` tag with the chosen attributes and attaches the `videojs/videojs` asset library. That library (declared in `videojs.libraries.yml`) points at the Video.js 5.x CDN (`//vjs.zencdn.net/5.0`) by default; the `videojs.settings` config object (`videojs_location`, `videojs_directory`) records where the library lives and `videojs_get_version()` can probe an installed copy's version. There is no admin settings form (`configure` is null) and no permissions. A themeable `videojs` theme hook is also exposed so custom code can render a player directly (see README for its `items`/`player_id`/`attributes` variables). Note the shipped `videojs.libraries.yml` `remote` line has a `https//` typo but the CDN JS/CSS `//vjs.zencdn.net/...` URLs are correct.

---

- Render an uploaded MP4/WebM/Ogg File field as an HTML5 Video.js player.
- Play a core Media/Video reference field with the Video.js skin.
- Show a multi-value video field as one player offering multiple source formats (MP4 + WebM fallback).
- Set explicit player width and height per view mode.
- Enable or hide the player controls per display.
- Autoplay a background/hero video (combine with muted for browser autoplay policies).
- Loop a short clip continuously.
- Mute a video by default.
- Tune the `preload` hint (none/metadata/auto) to control bandwidth on page load.
- Serve the player from the Video.js CDN without installing any library locally.
- Point the module at a self-hosted `libraries/video-js` copy via the `videojs.settings` config.
- Detect the installed Video.js version programmatically with `videojs_get_version()`.
- Provide alternative source formats so the browser picks the codec it supports.
- Use the `videojs` theme function to render a player from custom code with your own item list.
- Attach subtitle/caption VTT tracks by uploading VTT files alongside the video (per README).
- Display a poster image from a separate image field for the video thumbnail.
- Offer a consistent cross-browser/device video experience via a single formatter.
- Reuse the same formatter settings across many content types' video fields.
- Combine with core Media to standardize video presentation site-wide.
