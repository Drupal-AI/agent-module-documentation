<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming & JavaScript

The visible markup is intentionally thin: the module registers theme hooks whose templates
**delegate to the active theme**, and playback is driven by bundled JS behaviours.

## Theme hooks (`varbase_heroslider_media_theme()` in the `.module`)

| Theme hook | Template | Base hook |
| --- | --- | --- |
| `node__varbase_heroslider_media` | `templates/node--media-hero-slide.html.twig` | `node` |
| `views_view__varbase_heroslider_media` | `templates/views-view--media-hero-slider.html.twig` | `view` |
| `media_oembed_iframe__remote_video__varbase_media_hero_slider` | `templates/media-oembed-iframe--remote-video--varbase-media-hero-slider.html.twig` | (custom; vars `provider`, `media`) |

**Delegation pattern.** The node and view templates contain almost no markup — they do
`{% include active_theme ~ ':media-hero-slide' %}` and
`{% include active_theme ~ ':media-hero-slider' with { … } %}`. The real markup therefore lives in
the **active theme** (Vartheme/Bootstrap-based theme in the Varbase stack) under those include
names. To restyle the slider, override those theme includes (or override the module templates in
your theme to change the delegation).

## Preprocess hooks

- `…_preprocess_node__varbase_heroslider_media(&$vars)` — loads `field_media_single`, and when the
  referenced media is a `remote_video` sets `$vars['provider']` from the media's `field_provider`
  (so the template knows youtube vs vimeo).
- `…_preprocess_media_oembed_iframe__remote_video__varbase_media_hero_slider(&$vars)` — populates
  `type`, `provider`, `view_mode` from the request query, plus `base_path` and the module path, so
  the iframe template can load the matching `oembed-frame.heroslider.{provider}.js`.

## The oEmbed iframe template

`media-oembed-iframe--remote-video--varbase-media-hero-slider.html.twig` overrides core's media
oEmbed iframe for the hero-slider view mode. It emits a minimal HTML document that (a) includes
`js/oembed-frame.heroslider.{{ provider }}.js` and (b) prints the oEmbed media markup. This is the
frame the remote video actually plays in; the parent page talks to it via `postMessage`.

## JavaScript libraries (`varbase_heroslider_media.libraries.yml`)

Two contexts — know which one a playback bug is in:

**Run in the parent page** (coordinate the Slick carousel with the videos):
- `local_video_slider` → `js/video.heroslider.local.js` — plays/pauses `<video>` elements, advances
  the slide on video end, autoplays the first slide's video muted.
- `youtube_video_slider` → `js/video.heroslider.youtube.js` — `postMessage('play'|'pause')` to
  YouTube iframes on slide change; advances on `endedYoutube`.
- `vimeo_video_slider` → `js/video.heroslider.vimeo.js` — same pattern for Vimeo.

**Run inside the oEmbed iframe** (control the embedded player):
- `oembed-frame-video-youtube` → `js/oembed-frame.heroslider.youtube.js` — loads the YouTube
  Player API, mutes/autoplays, rewrites the iframe src params, relays state to the parent via
  `postMessage`.
- `oembed-frame-video-vimeo` → `js/oembed-frame.heroslider.vimeo.js` — same for Vimeo.

If hero video misbehaves, first decide whether the fault is in a page-context script or an
iframe-context script.

## Styling hooks

- View wrapper CSS class `varbase-heroslider-media`; Slick adds
  `.slick--view--varbase-heroslider-media`.
- Media wrappers carry `vw-100 varbase-video-player ratio ratio-16x9` (Display Suite outer class),
  and slide text is wrapped as `<div class="slick__text">…</div>` by the view field rewrite.
