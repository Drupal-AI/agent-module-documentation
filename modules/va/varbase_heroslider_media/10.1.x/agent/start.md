<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Hero Slider (varbase_heroslider_media) — agent index

> **Deprecated.** `varbase_heroslider_media.info.yml` declares `lifecycle: deprecated` and
> `package: Varbase (deprecated)`. Document or migrate existing use; do not recommend it for
> new work.

A pre-built homepage hero slider for Varbase: a **Hero slider** node type whose slides (title,
text, one image/video, one CTA link) are ordered by an **Entityqueue** and rendered as a **Slick**
carousel through a view. The module itself is only templates + JS + a small `.module`; the whole
feature is shipped as a **Drupal recipe** and created by applying it.

Key facts:
- **No routes, no permissions, no services, no plugin types, no `config/install`, no `src/`.** The
  module provides `hook_theme()`, two preprocess hooks, `hook_requirements()`, and `hook_install()`.
- **Structure ships as a recipe** at `recipes/default/` (`recipe.yml` + `config/`). Enabling the
  module does **not** create the content type — you must apply the recipe (`drush recipe …`).
  Verified: on this site the module is enabled but node type `varbase_heroslider_media` is absent
  because the recipe was not applied.
- Dependencies: `varbase_media`, `varbase_components`, `slick`, `slick_views`. `install:` list also
  pulls in `link`, `menu_ui`, `entityqueue`, `rabbit_hole`, `field_group`, `length_indicator`,
  `advanced_text_formatter`, `maxlength`. **Not usable outside the Varbase stack.**
- Requires the front-end **Slick library** at `/libraries/slick/slick/slick.js`
  (`hook_requirements` errors if missing — see `includes/helpers.inc`).

## What you'd do → where

- **Recreate/understand the feature: recipe, content type, entityqueue, view/block, Rabbit Hole,
  Slick optionset** → [configure/media-hero-slider.md](configure/media-hero-slider.md)
- **The three slide fields (media, text, link), their widgets and formatters** →
  [fields/slide-fields.md](fields/slide-fields.md)
- **Theme hooks, the three Twig templates, JS libraries, oEmbed iframe playback** →
  [theming/theming.md](theming/theming.md)

## Key facts (real machine names)

- Node type: `varbase_heroslider_media` (label "Hero slider"), new_revision on, preview optional,
  submitted-by hidden.
- Fields (all on the node bundle): `field_media_single` (entity_reference → media, **required**,
  bundles image/remote_video/video, Media Library widget), `field_brief` (`string_long`,
  "Slide text"), `field_link` (`link`, "Call for action link").
- View: `varbase_heroslider_media` (base `node_field_data`) — default display + block display
  `varbase_heroslider_media`; style `slick` (optionset `varbase_slick`), row `ds_entity:node`,
  filtered to published `varbase_heroslider_media`, sorted/related via `entity_queue`
  (`limit_queue: varbase_heroslider_media`). Access: `perm: 'access content'`.
- Entityqueue: `entity_queue.varbase_heroslider_media` (handler `simple`, `act_as_queue`,
  `max_size: 6`, target bundle `varbase_heroslider_media`).
- Slick optionset: `slick.optionset.varbase_slick` (autoplay 5000ms, fade, infinite, 1 slide,
  arrows on, dots off).
- Rabbit Hole: `rabbit_hole.behavior_settings.node.varbase_heroslider_media` — `page_redirect`
  to `<front>` (301), so slide nodes have no standalone page.
- Tour: `tour.tour.media_hero_slider_creation` on `node.add/varbase_heroslider_media`.
- Media view mode: `media.varbase_media_hero_slider` (used by image/remote_video/video displays).
- Theme hooks: `node__varbase_heroslider_media`, `views_view__varbase_heroslider_media`,
  `media_oembed_iframe__remote_video__varbase_media_hero_slider`
  (`varbase_heroslider_media_theme()` in the `.module`).
- Libraries (`varbase_heroslider_media.libraries.yml`): `local_video_slider`,
  `youtube_video_slider`, `vimeo_video_slider`, `oembed-frame-video-youtube`,
  `oembed-frame-video-vimeo`.
- Install helper: `Vardot\Installer\ModuleInstallerFactory::installList()` (enables the `install:`
  list) + `EntityDefinitionUpdateManager::applyUpdates()`; cross-release updates in
  `includes/updates/v{8,9,10}.inc`.
