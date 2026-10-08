<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shipped fields (config/install)

The module installs three fields (plus their storages) that hold header-slideshow assignments.
All target the `media` bundle **`slideshow`** and are `translatable: true`.

## `field_slideshow_ref` on `node.page`

- Storage `field.storage.node.field_slideshow_ref`: `entity_reference` → `media`, cardinality 1.
- Field `field.field.node.page.field_slideshow_ref`: bundle `page`, label **"Header Slideshow"**,
  `required: false`. Handler `default:media`, `target_bundles: {slideshow: slideshow}`.
- Purpose: a **per-node override**. Its description says a slideshow selected here overrides one
  assigned via the header-slideshow management, and points editors to `/admin/content/header-slides`
  for menu-strand assignments. This field is consumed by the `drowl_headerslides_slideshow_ref`
  view/block, **not** by the menu blocks — see [../views/views.md](../views/views.md).

## `field_slideshow_ref` on `menu_link_content.main`

- Storage `field.storage.menu_link_content.field_slideshow_ref`: `entity_reference` → `media`,
  cardinality 1, `locked: true`.
- Field `field.field.menu_link_content.main.field_slideshow_ref`: bundle `main` (the main menu),
  label **"Header Slideshow"**, description "Optionally select a slideshow to be used for this menu
  item (and submenu items, unless overridden)." Handler `default:media`,
  `target_bundles: {slideshow: slideshow}`.
- Purpose: the assignment the **menu Block plugins** read while walking the active trail
  (see [../blocks/menu-slideshow-blocks.md](../blocks/menu-slideshow-blocks.md)). Editing menu-link
  fields requires the `menu_item_extras` dependency.

## `field_slideshow_inherit` on `menu_link_content.main`

- Storage `field.storage.menu_link_content.field_slideshow_inherit`: `boolean`, cardinality 1,
  `locked: true`.
- Field `field.field.menu_link_content.main.field_slideshow_inherit`: bundle `main`, label
  **"Inherit slideshow on submenu items"**, on/off labels "Yes"/"No", **default value `1`**.
- Purpose: when truthy on a parent menu item, that item's `field_slideshow_ref` slideshow cascades
  to descendant pages that have no slideshow of their own. Read in
  `MenuSlideshowRefSlidesBlock::determineActiveTrailMediaHeaderSlideEntity()`.

## Adding the fields to another menu

The menu fields are bundle-specific to `main`. To use header slideshows on another menu you must
add equivalent `field_slideshow_ref` / `field_slideshow_inherit` field instances to that menu's
`menu_link_content` bundle and add the menu to `drowl_header_slides.settings:menus`.
