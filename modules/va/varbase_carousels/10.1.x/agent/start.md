<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Varbase Carousels (varbase_carousels) — agent index

Ships a **carousel block-content type** (`varbase_carousel_block`) for Varbase: an editor adds
media slides to a block and places it in any region. It is a **configuration-only feature module** —
no PHP `src/`, no route, no settings form. Slides render through Slick.

- No settings page (`configure` is null). Operate it through core block-content and Slick UIs.
- Defines **no** permissions.yml, **no** drush commands, **no** plugin types, **no** config schema
  of its own (schema for the shipped config comes from `block_content`, `field`, and `slick`).
- Dependencies (`.info.yml`): core `block`, `block_content`, `text`, `field`, `user`, `options`,
  `link`, `filter` + `ctools:ctools_block`, `varbase_media:varbase_media`, `slick:slick`.
  Composer adds `vardot/module-installer-factory`, `vardot/entity-definition-update-manager`,
  `drupal/varbase_media ~10.1.0`, `drupal/ctools ~3 || ~4`.

Solution docs:
- **Create / place / tune a carousel** → [configure/carousel.md](configure/carousel.md)
- **The carousel-slides field, widget & Slick formatter** → [fields/media-carousel-slide.md](fields/media-carousel-slide.md)
- **Who may create/edit/delete carousels** → [permissions/permissions.md](permissions/permissions.md)

Key facts (real machine names):
- Block type: `varbase_carousel_block` (label "Carousel"). Add form: `/block/add/varbase_carousel_block`.
- Field: `field_media_carousel_slide` — entity_reference → media (bundle `image`), cardinality `-1`.
- Slick optionset (config): `slick.optionset.varbase_carousel` (id `varbase_carousel`).
- Media view mode (optional config): `core.entity_view_mode.media.slick` (`media.slick`).
- Display formatter: `slick_media` (from slick) using optionset `varbase_carousel`, `view_mode: media_04_03`.
- Form widget: `media_library_widget` (+ `media_library_edit`).
- Install hook: `varbase_carousels_install()` runs Vardot `ModuleInstallerFactory` (install list,
  optional config import, `addPermissions`) + `EntityDefinitionUpdateManager`. Update hook: `9001`.
- Note: the shipped `core.entity_view_display.block_content.varbase_carousel_block.default` depends
  on the **`ds`** (Display Suite) module, which the Varbase distribution supplies; enabling on a bare
  site without `ds` fails on that config dependency. Install the distribution (or `ds`) first.
