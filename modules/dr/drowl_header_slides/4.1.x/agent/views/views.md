<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shipped Views (config/install)

Three views are installed. Each display uses access `perm: 'access content'`.

## `drowl_header_slideshow_fallback` — the fallback slideshow

- Label "DROWL Header Slides > Header Slideshow Fallback". Base `media_field_data` (`mid`).
- Filters: `status = 1` (published) and `bundle = slideshow` — i.e. published slideshow media.
- Displays: `block_page_width` (renders media in view mode `default` / page/container width) and
  `block_viewport_width` (view mode `viewport_width`, full browser width). Descriptions:
  "Display slideshow on maximum width (.container)" and "Display the slideshow on the full width".
- Role: the **site-wide fallback** shown when the menu blocks resolve nothing. Placed as
  `views_block:drowl_header_slideshow_fallback-block_page_width` /
  `-block_viewport_width`; these are among the blocks whose placeholdering is disabled by
  `hook_block_build_alter` so an empty result can be detected.

## `drowl_headerslides_slideshow_ref` — per-node referenced slides

- Label "DROWL Header Slides > Referenced Slides". Description: "Header image block for
  field_slideshow_ref which can be used in content to override other slideshow types." Base
  `node_field_data` (`nid`).
- Contextual filter: `nid` (the current node). Renders the node's `field_slideshow_ref` via the
  `entity_reference_entity_view` formatter (view mode `default` on `block_page_width`, and a
  viewport-width variant on `block_viewport_width`).
- Role: displays a **per-page node override** slideshow (the `node.page.field_slideshow_ref` field,
  see [../fields/slideshow-fields.md](../fields/slideshow-fields.md)). `update_8002` removed the
  published-status filter from its `default` display.

## `drowl_header_slides_admin_media_slideshow` — editor overview

- Label "DROWL Header Slides > Slideshow Administration", description "Slideshow administration
  overview". Base `media_field_data` (`mid`).
- `page` display at path **`admin/content/header-slides`**, menu link "Slideshows" (weight 5) under
  the admin content menu. Access `perm: 'access content'`.
- Lists slideshow media with exposed filters plus convenience link fields to `/media/add/slideshow`,
  `/admin/structure/menu/manage/main`, and `/admin/content/media?type=slide`. `hook_views_pre_render`
  historically attached `drowl_media/admin_media_library` (keyed on the legacy view id).
- Replaces the pre-4.x `admin_media_slideshow_overview` view (`update_8003`).

## Notes

- The carousel behaviour (Slick/Blazy, per-slide fields) is not configured in these views — they
  render the slideshow **media entity** in a view mode; the media type's own display (from
  `drowl_media`) provides the slider markup.
- These views ship in `config/install`, so re-importing/reverting them requires Features or a manual
  config import.
