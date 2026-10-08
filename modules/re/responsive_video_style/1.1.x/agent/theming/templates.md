<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming

Two theme hooks are declared in `src/Hook/ResponsiveVideoStyleHooks.php` (`#[Hook('theme')]`), one
per responsive strategy. Both auto-escape all values through Twig.

## `responsive_video_style` (source strategy)

Template `templates/responsive-video-style.html.twig`. Variables:

- `sources` — array of source descriptors; each has `src`, optional `media` (breakpoint media
  query), optional `type` (built as `mime; codecs="…"`), and `attributes`.
- `attributes` — shared `<video>` tag attributes (from `getVideoTagAttributes()`: `controls`,
  `autoplay`, `loop`, `muted`, `playsinline`, `preload`, optional `width`/`height`, optional
  `poster`).
- `fallback_text` — text node inside `<video>`.

Markup: a `.responsive-video-style` wrapper `<div>` containing one `<video>`; boolean-`true`
attributes render as bare attributes, other non-empty/non-false/non-null values render as
`name="value"`; each `source` becomes a `<source src=… [media=…] [type=…] …>`. The original uploaded
file is appended by the builder as the final fallback `<source>`.

## `responsive_video_style_variants` (variant strategy)

Template `templates/responsive-video-style-variants.html.twig`. Variables:

- `variants` — each has `media_query`, `hidden` (bool), and **either** `content` (a provider-owned
  render array, for `provider_rendered` mode) **or** `attributes` + `sources` (native mode).
- `fallback_text`.

Markup: a `.responsive-video-style--variants` wrapper with `data-responsive-video-style-variants`;
each variant is a `<div … data-responsive-video-style-variant [data-media-query=…] [hidden]>` holding
either the provider `content` or a native `<video>`. The attached library
`responsive_video_style/frontend` (`js/responsive_video_style.js`) shows exactly one variant at a
time: on attach and on `matchMedia` change it un-hides the variant whose `data-media-query` matches
(or the one with no media query / the first) and hides the rest.

## Libraries (`responsive_video_style.libraries.yml`)

- `frontend` — `js/responsive_video_style.js`; deps `core/drupal`, `core/once`. Attached by the
  variant render element.
- `admin` — `css/responsive_video_style.admin.css` + `js/responsive_video_style.admin.js`; deps
  `core/drupal`, `core/once`. Attached by the config form.

To override markup, provide your own `responsive-video-style.html.twig` /
`responsive-video-style-variants.html.twig` in your theme, or implement a preprocess for the two
theme hooks.
