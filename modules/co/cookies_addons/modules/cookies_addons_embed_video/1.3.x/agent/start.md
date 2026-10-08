<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookies Addons Embed Video (cookies_addons_embed_video) — agent index

Submodule of **Cookies Addons**. A **text-format filter** that gates **YouTube** `<iframe>` embeds
behind consent, deferring to the COOKiES Video module's placeholder. Package COOKiES. Core `^9.2 ||
^10 || ^11`. Depends on `cookies:cookies_video`. License GPL-2.0-or-later. Version 1.3.3.

- **Filter, regex, install/update and library** → [plugins/filter.md](plugins/filter.md)

## What it provides

- Filter plugin `CookiesAddonsEmbedVideoFilter`
  (`src/Plugin/Filter/CookiesAddonsEmbedVideoFilter.php`) — id `cookies_addons_embed_video_filter`,
  title "Block YouTube videos", `type = TYPE_TRANSFORM_IRREVERSIBLE`, constant `EXTRA_CLASS =
  'cookies-video-embed-field'`. `process()` uses `Html::load()`, and for each iframe whose `src`
  matches `_cookies_addons_embed_video_is_youtube()` sets `src=''`, `data-src=<orig>`, adds the class,
  and attaches library `cookies_video/cookies_video_embed_field` (from COOKiES Video).
- Helper `_cookies_addons_embed_video_is_youtube($src)` (`cookies_addons_embed_video.module`) — regex
  matching youtu.be / youtube(-nocookie).com video URLs.
- Install: `cookies_addons_embed_video_update_8001()`
  (`cookies_addons_embed_video.install`) renames the mistyped filter id
  `cookies_addons_embed_viedeo_filter` → `cookies_addons_embed_video_filter` across all
  `filter.format.*`.
- Config schema `filter.settings.cookies_addons_embed_video_filter` (empty mapping — no settings).
- Tests: `tests/src/Functional/TestCookiesAddonsEmbedVideoFilterFunctional.php`.
- No routes, permissions, services, own JS library (reuses `cookies_video`), Drush.

Privacy/consent gate. The filter only relocates the author-supplied `src` to `data-src`; the
placeholder/overlay is provided by the COOKiES Video module.
