<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Kickstart Demo Assets (commerce_kickstart_demo_assets) — agent index

Ships the code assets the **Commerce Kickstart Demo recipe** needs but a recipe cannot itself
provide: a Layout Builder **"Slideshow"** layout (a slick carousel) with its Twig template and
JS/CSS libraries, plus glue that makes the recipe's imported default content work — a `node_presave`
hook that rewrites Layout Builder UUID references to local entity IDs, and an event subscriber that
re-indexes the `products` Search API index after import. A demo/asset support module, not a
standalone feature.

- No settings page (`configure` = null); no routes, no permissions, no drush commands, no config schema.
- Not installed directly — pulled in as part of the Commerce Kickstart demo (composer requires
  `centarro/commerce_kickstart:^5`).
- info.yml declares **no** module dependencies, but the code needs these (undeclared, supplied by the
  demo environment): `bootstrap_layout_builder`, `search_api`, `layout_builder`, `media`,
  `block_content`, and core `node`.

Solutions:
- **Use / understand the Slideshow layout, its template and slick carousel** → [plugins/slideshow_layout.md](plugins/slideshow_layout.md)
- **Understand the Layout Builder content fix-up on default-content import** → [hooks/node_presave.md](hooks/node_presave.md)
- **Understand the post-import Search API re-index** → [events/default_content_import.md](events/default_content_import.md)

Key facts (real machine names):
- Layout plugin id `cklb_slideshow` (class `SlideshowLayout` extends `bootstrap_layout_builder`'s
  `BootstrapLayout`); template `cklb_slideshow`; single region `main`.
- Libraries: `commerce_kickstart_demo_assets/cklb-slideshow` (js/cklb-slideshow.js; deps
  `core/jquery`, `core/once`, own `slick`) and `commerce_kickstart_demo_assets/slick` (external
  slick-carousel from cdnjs).
- JS behavior `Drupal.behaviors.slickSlider`, on `.cklb-slideshow:not(.layout-builder__region)`.
- Hook `commerce_kickstart_demo_assets_node_presave()` (+ helper
  `_commerce_kickstart_demo_assets_process_bootstrap_styles()`).
- Service `commerce_kickstart_demo_assets.event_subscriber` → `DefaultContentSubscriber` (tags
  `event_subscriber`, `needs_destruction`); subscribes `PreImportEvent` and `RecipeAppliedEvent`;
  re-indexes `search_api_index` `products`.
- Core requirement `^11` (Drupal 11 only). Version `1.0.x`.
