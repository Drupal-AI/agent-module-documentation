<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Vanilla Javascript Parallax (vvjp) — agent index

Adds one **Views style (format) plugin**, `views_vvjp` ("Views Vanilla JavaScript Parallax"), that
renders each Views row as a scroll-driven parallax section: an image background that transforms on
scroll (translate / blur / opacity / scale / rotate), an optional color overlay, a configurable
section height/width, and a CSS scroll-effect on the foreground content. Front-end behavior runs in a
`<vvjp-parallax>` custom element (JS `Drupal.behaviors.VVJParallax`) that extends `vvj_core`'s
`ElementBase`; below a chosen breakpoint the parallax is dropped and a plain `<img>` is swapped in,
and `prefers-reduced-motion` forces the scroll offset to 0. There is **no config/settings page** —
everything is configured in the Views UI style-options form for a display whose **Show** is *Fields*
and whose **first field is an image using the "URL to image" (`image_url`) formatter** (that URL
becomes the background). A `<div class="vvjp-separator"></div>` field between the image URL and the
foreground fields tells the template where to split background from content.

v2 sits on the **`drupal/vvj_core` foundation** (a hard module dependency; `vvjp_update_10001`
auto-enables it on upgrade). It also registers a token namespace, `[vvjp:FIELD]` /
`[vvjp:FIELD:plain]`, resolved through `vvj_core.token_resolver` for use in Views text areas.

- Depends on: `views`, `filter`, `vvj_core:vvj_core` (all hard deps in info.yml).
- Core: `^11.3 || ^12`. PHP: `>=8.3`. Package: `VVJ`.
- No `configure` route, no permissions, no drush, no custom routes/controllers/access. Provides
  config schema (`views.style.views_vvjp`) and one Views style plugin. Registers a token type and a
  `hook_help` page at `/admin/help/vvjp` (renders README.md).
- Optional example View `views.view.vvjp_example` (`config/optional/`) installs when no ID conflicts.

## What you'd do → where

- **Set up a parallax view / all format-option keys, defaults, bounds, the `image_url` +
  separator requirement, validation, templates, libraries** → [plugins/views-style.md](plugins/views-style.md)
- **Put a Views field value in a header/footer/empty text area (`[vvjp:FIELD]` tokens)** →
  [hooks/tokens.md](hooks/tokens.md)

## Key facts (real machine names)

- Views style plugin: id `views_vvjp`, class `Drupal\vvjp\Plugin\views\style\Parallax`, base
  `Drupal\vvj_core\Plugin\views\style\VvjStylePluginBase`, theme `views_view_vvjp`,
  `display_types: ['normal']`. Module slug `vvjp`; custom element tag `vvjp-parallax`.
- Theme hooks: `views_view_vvjp` (template `views-view-vvjp.html.twig`), `views_view_vvjp_fields`
  (template `views-view-vvjp-fields.html.twig`) — declared in `VvjpThemeHook`.
- Preprocess (`VvjpPreprocessHooks`): `preprocess_views_view_vvjp`, `preprocess_views_view_vvjp_fields`,
  `preprocess_views_view` (adds legacy class `vvj-parallax`).
- Config schema: `views.style.views_vvjp`. Option keys: `unique_id`, `parallax_speed`,
  `background_position`, `overlay_color`, `overlay_opacity`, `section_height` ({`value`,`unit`}),
  `available_breakpoints`, `bg_animation_easing`, `bg_animation_speed`, `max_width`, `enable_css`,
  `scroll_effect`, `disable_overlay`, `over_content_only`.
- Constants: `Drupal\vvjp\VvjpConstants` (all option enums + defaults + bounds). Required first-field
  formatter: `image_url` (`REQUIRED_FIELD_TYPE`).
- Token type `vvjp` (`VvjpTokenHooks`): `hook_token_info` + `hook_tokens`; `[vvjp:FIELD]` /
  `[vvjp:FIELD:plain]`, delegated to `@?vvj_core.token_resolver`.
- Services: `Drupal\vvjp\Hook\VvjpHelpHook`, `…\VvjpThemeHook`, `…\VvjpPreprocessHooks`,
  `…\VvjpTokenHooks` (all `#[Hook]` attribute classes wired in `vvjp.services.yml`).
- Libraries: `vvjp` (JS `js/vvjp.js`, `js/vvjp-parallax-element.js` + CSS; deps
  `vvj_core/{tokens,base,a11y,element-base}`), `vvjp-style`, and breakpoint CSS
  `vvjp__all` / `vvjp__576` / `vvjp__768` / `vvjp__992` / `vvjp__1200` / `vvjp__1400`.
- Install hook: `vvjp_update_10001` — installs `vvj_core` if missing (v1→v2 upgrade).
