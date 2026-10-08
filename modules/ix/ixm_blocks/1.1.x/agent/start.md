<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IXM Blocks (ixm_blocks) — agent index

Shell module (vendor prefix **IXM** = ImageX) that ships a set of ready-made **custom block types**.
Version **1.1.3**. Core `^10 || ^11` (submodules declare `^8 || ^9 || ^10 || ^11`).

## What it actually is
- The base `ixm_blocks` module is nearly empty. Its only PHP is
  `ixm_blocks_theme_suggestions_block_alter()`, which adds `block__BUNDLE` and
  `block__BUNDLE__VIEWMODE` theme suggestions so each block type gets its own template.
  Its only hard dependency is `block_content`.
- Every component is a **submodule** that ships, as `config/optional`, a `block_content` **bundle**
  (+ usually a Paragraphs type, field storages/instances, and default form & view displays) and
  registers a `block--ixm-blocks-*.html.twig` template via `hook_theme()`.
- So this is a **block_content bundle + Twig template pack**, not a set of Block *plugins* and not a
  configurable module (no permissions, no routes, no settings form, no Drush commands).

## Components (enable per submodule: `drush en ixm_blocks_<name> -y`)
| Submodule | Block bundle | Repeating rows (Paragraph type) | Notes |
|---|---|---|---|
| `ixm_blocks_accordion` | ixm_blocks_accordion | ixm_blocks_accordion_item (title, body) | Bootstrap accordion |
| `ixm_blocks_cards` | ixm_blocks_cards | ixm_blocks_card (title, body, media, links) + node ref | Card grid; also `field_content_reference` to nodes |
| `ixm_blocks_carousel` | ixm_blocks_carousel | ixm_blocks_carousel_item (title, body, media) | Bootstrap carousel |
| `ixm_blocks_cta_icons` | ixm_blocks_cta_icons | ixm_blocks_cta_icon_item (title, body, media, link) | Icon/CTA row; SVG passthrough |
| `ixm_blocks_hero` | ixm_blocks_hero | ixm_blocks_hero_banner (title, body, media, links) | Only submodule with real PHP; media→image-style / YouTube / Vimeo / local video |
| `ixm_blocks_modal` | ixm_blocks_modal | — (body + field_modal_trigger) | Bootstrap modal |
| `ixm_blocks_ping_pong` | ixm_blocks_ping_pong | ixm_blocks_ping_pong_item (title, body, media, links, options) | Alternating image/text |
| `ixm_blocks_statistics` | ixm_blocks_statistics | ixm_blocks_statistics_item (title, prefix/number/suffix, media, body, links) | Count-up via ScrollMagic |
| `ixm_blocks_table` | ixm_blocks_table | — (body only) | Responsive via Tablesaw CDN |
| `ixm_blocks_tabs` | ixm_blocks_tabs | ixm_blocks_tab_item (title, body) | Bootstrap tabs |
| `ixm_blocks_boilerplate` | ixm_blocks_boilerplate | ixm_blocks_boilerplate (title, body) | **hidden**; copy-paste template for a new block type |

## Dependencies & front-end
- Base composer requires `drupal/paragraphs ~1.0` and `drupal/twig_tweak ~3.0`; component submodules
  pull in `paragraphs`, `media`, `link`, `twig_tweak` as needed.
- Markup is Bootstrap 5. Per-component CDN libraries: Swiper 11 (hero swiper), Tablesaw 3.1.2 (table),
  ScrollMagic 2.0.7 + jQuery.animate (statistics), Vimeo Player API (hero).
- Optional `block_library` module: each bundle carries a `third_party_settings.block_library.icon_path`
  so the type shows an icon in the Layout Builder off-canvas tray.

## Where to look
- `agent/blocks/block-types.md` — per-component fields, template, libraries, and the config layout.
- `agent/blocks/theming-and-extending.md` — template overrides, hero macros/variants, the boilerplate pattern.
- Templates are the payload and are meant to be overridden in your theme.
