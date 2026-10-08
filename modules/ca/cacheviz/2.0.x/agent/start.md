<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache Visualization (cacheviz) — agent index

Developer tool that **overlays render-cache metadata (tags / contexts / max-age) onto rendered pages** to
debug caching. It decorates core's `renderer` to wrap cacheable render-array output in HTML comments carrying
that element's cache metadata; a JS panel parses the comments and shows highlights, an issues list and a
bubble-chain root-cause view. Package `Development`. Core `^11`, PHP `>=8.3`. Version **2.0.0-alpha1**.
License GPL-2.0-or-later. **No** module dependencies, **no** `.module`/`.install`, **no** Drush, **no** entities.
Dev/staging tool — exposes internal cache metadata; gate to developers.

## What it actually provides (from source)

- **Service decorator** `cacheviz.renderer` (`src/Renderer.php`, `decorates: renderer`, extends core
  `Renderer`) — the core of the module. In `doRender()` it calls the parent, then (if enabled) wraps the
  element's markup in `<!--CACHEVIZ_START--><!--{json}--><!--CACHEVIZ_END-->`, where `{json}` is
  `htmlspecialchars(Json::encode(...), ENT_NOQUOTES)` of `final` + `pre_bubbling` cache metadata + resolved
  context keys.
- **Event subscriber** `cacheviz.response_subscriber` (`src/EventSubscriber/ResponseSubscriber.php`,
  `KernelEvents::RESPONSE` priority `-100`) — injects a `drupal-settings-json-cacheviz` `<script>` (page-level
  tags/contexts/max-age read from `X-Drupal-Cache-*` response headers) plus `<link>`/`<script>` tags for the
  module's CSS/JS (with `?v=filemtime` cache-busting) before `</head>`/`</body>` on `text/html` responses.
- **Path service** `cacheviz.path_matcher` (`src/PathMatcher.php`) — wraps core `path.matcher` to test the
  current path against the `excluded_paths` config.
- **Config form** `SettingsForm` (`src/Form/SettingsForm.php`, `ConfigFormBase`) at route `cacheviz.settings`.
- **Two permissions** (`cacheviz.permissions.yml`, both `restrict access: true`): `view cacheviz debug`,
  `administer cacheviz`.
- **Config**: `cacheviz.settings` (`enabled`, `auto_highlight_problems`, `excluded_paths`) with schema.
- **Front-end**: `js/cacheviz.comments.js` (comment parser → `window.CachevizComments`) and `js/cacheviz.js`
  (analyzer + panel UI, exposes `window.cacheviz`), plus two CSS files. Not registered as a Drupal library.

## Routes & access

- `cacheviz.settings` → `GET /admin/config/development/cacheviz`, `_permission: 'administer cacheviz'`. Only
  route in the module. No other endpoints, no state-changing GET, no REST/callbacks.

## Gating (all three must hold for visualization to appear)

`cacheviz.settings:enabled` is TRUE **and** current user has `view cacheviz debug` **and** current path is not
excluded — checked in both `Renderer::shouldProcessRequest()` and `ResponseSubscriber::shouldProcess()`.

## Solution docs

- **How it hooks rendering, the comment format, the response injection, and the JS panel** →
  [architecture/rendering.md](architecture/rendering.md)
- **Install/enable, the settings form, config object + schema, permissions, path exclusions** →
  [config/settings.md](config/settings.md)
