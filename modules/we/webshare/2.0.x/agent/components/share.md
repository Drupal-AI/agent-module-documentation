<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webshare — the `webshare:share` SDC & Drupal Canvas integration

## Single-directory component (`components/share/`)
`share.component.yml` (status `stable`), `share.twig`, `share.css`, `share.js`. Library overrides
depend on `core/drupal` and `core/once`; the SDC auto-attaches its own scoped CSS/JS, so callers
need no `#attached` library. This is the render target for both the Block plugin and Drupal Canvas.

### Declared props (mirror the block settings 1:1, so Canvas shows the same UX)
`heading` (default `Share`), `display_title` (bool, default true), `heading_level` (enum 2–6,
default 2), `alignment` (`start`/`end`, default `end`), `orientation` (`horizontal`/`vertical`,
default `vertical`), `mobile_visibility` (`all`/`hide_mobile`/`mobile_only`), `native_share` (bool),
`placement` (`inline`/`rail-end`), plus implementation props `url`, `share_title`, `share_text`
(default `''`).

### Intentionally UNdeclared props
`platforms` (array-of-objects), `webshare_links_id`, `native_label`, `native_icon`,
`native_icon_html`. Drupal Canvas cannot map an array-of-objects to a field widget, so declaring
`platforms` would make the whole SDC ineligible for the Canvas component library. Instead the Twig
falls back to the `webshare_share_data()` function (below).

### Twig rendering (`share.twig`)
When `platforms`/`url` are absent (the Canvas case) it calls `webshare_share_data(url, options)` to
resolve them for the current request. Emits a `<nav>` with `data-webshare-url` / `-title` / `-text`
attributes (read by `share.js`), an optional `<h{heading_level}>` heading, then a `<ul>` of items:
the optional native button (`.webshare__native-button`), a copy button
(`.webshare__copy-button[data-webshare-copy]`) for `is_copy` platforms, and `<a target="_blank"
rel="noopener noreferrer">` links for the rest. Each item prefers pre-rendered Icons-API markup
(`icon_html`) over the `<img src="{icon_src}">` bundled SVG.

### Behavior (`share.js`, `Drupal.behaviors.webshareNative`)
- Copy buttons: `click` copies `data-webshare-copy` (or `window.location.href`) via
  `navigator.clipboard` (with a legacy `execCommand('copy')` fallback) and flashes a
  `webshare--copied` state.
- Native button: if `navigator.share` exists, builds a payload from the `nav`'s
  `data-webshare-url/title/text` (omitting empty fields, honoring `navigator.canShare`) and calls
  `navigator.share()`; on desktop it falls back to copying the URL. `AbortError` /
  `NotAllowedError` / `InvalidStateError` are treated as expected outcomes.

## Twig extension (`webshare.twig_extension`, `TwigExtension/WebshareTwigExtension`)
Registers the `webshare_share_data($url = '', $options = [])` Twig function. Resolves `$url` to the
current route when empty, derives a stable `$id`, calls `WebshareService::build()`, and bubbles the
build's cache metadata (notably the `webshare_platforms` cache tag) into the active render context
so a Canvas-rendered rail is invalidated when a platform changes. Returns `['url' => ...,
'platforms' => ...]`. Constructor args: `@webshare.service`, `@renderer`.

## Drupal Canvas
`drupal/canvas ^1.4` is a dev dependency. The SDC's `FullyValidatable` block schema and the
`platforms`-fallback design let the Share component be dropped onto content templates in Canvas with
the same configuration UX as the block, resolving the current page's share links at render time.

## Legacy theme templates
`webshare_theme()` (`webshare.module`) registers per-platform `webshare_<platform_id>` theme hooks
backed by `templates/webshare-platform.html.twig`, kept for older icon-pack integrations (e.g.
`vartheme_social`). `templates/webshare.html.twig` is the legacy block wrapper. The SDC does **not**
rely on these hooks.
