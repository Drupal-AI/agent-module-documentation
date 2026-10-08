<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming and extending

## Template suggestions
The base module's `ixm_blocks_theme_suggestions_block_alter()` inserts, for any `block_content`
block, the suggestions `block__<bundle>` and `block__<bundle>__<view_mode>` right after
`block__block_content`. Each component submodule then registers `block__ixm_blocks_<name>` in its
`hook_theme()` pointing at `templates/block--ixm-blocks-<name>.html.twig`.

To override a component's markup, copy that template into your theme's `templates/` directory and
edit it — the module's copy is intended as a Bootstrap 5 starting point, not a fixed widget. The
markup assumes Bootstrap 5 CSS/JS is present in your theme (the module does not ship Bootstrap
itself); a few components attach their own CDN libraries (Swiper, Tablesaw, ScrollMagic, Vimeo).

## Hero: variants and macros
`block--ixm-blocks-hero.html.twig` is macro-driven and supports two carousel engines selected by
`carousel_type` (`bootstrap` default, or `swiper`). Two thin templates set that up:
- `hero-extends-bootstrap.html.twig` — extends the hero template, adds `carousel-dark`/`carousel-fade`
  and Bootstrap ride/interval attributes.
- `hero-extends-swiper.html.twig` — sets `carousel_type = 'swiper'`.
Macros: `bootstrap_carousel`, `swiper_carousel`, `hero_slide` (shared), `carousel_control`. The
template exposes Twig `{% block %}`s (`hero_content`, `content`, `content_buttons`, `audio_buttons`,
`hero_image`, `hero_youtube`, `hero_vimeo`, `hero_html5`, `hero_preloader`) so a child template can
override individual pieces. Media resolution happens in PHP (`ixm_blocks_hero.module` preprocess),
which populates each slide's `#media_items`.

## Block Library icons
Each `block_content.type.*` config carries `third_party_settings.block_library.icon_path`. With the
contrib `block_library` module installed, that renders a per-type icon in the Layout Builder
off-canvas "add block" tray. The README recommends Material Icons (Rounded, Fill off, Weight 100,
Grade 200, 48px) to keep custom types visually consistent with these.

## Adding your own block type — the boilerplate pattern
`ixm_blocks_boilerplate` (hidden submodule) is a complete, minimal worked example. To package a new
block type the same way:
1. Create a submodule depending on `ixm_blocks` (+ `paragraphs` if it has repeating rows).
2. Ship the `block_content.type.*`, field storages/instances, Paragraphs type, and default form/view
   displays under `config/optional/`.
3. Register a `block__<bundle>` template in `hook_theme()` and add
   `templates/block--<bundle>.html.twig`.
4. Add any front-end assets via a `*.libraries.yml` and attach them from the template or a preprocess.
