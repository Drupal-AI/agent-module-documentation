<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gallery blocks

Two block plugins, both under category **"Media Gallery"**, both rendering through a
[layout plugin](../plugins/layouts.md) and both showing only **published** media, newest first,
capped at `item_count`.

| Block id | Class | Shows |
|---|---|---|
| `media_gallery_gallery` | `GalleryBlock` | One selected gallery (required `gallery_id` select) |
| `media_gallery_latest_items_all_galleries` | `LatestGalleryItemsBlock` | Latest items across **all** galleries |

Config schema for these blocks lives in `config/schema/media_gallery.schema.yml`
(`block.settings.media_gallery_gallery`, `block.settings.media_gallery_latest_items_all_galleries`).

## Settings (identical except `gallery_id`)

| Key | Default | Meaning |
|---|---|---|
| `gallery_id` | `''` | (`media_gallery_gallery` only) the gallery to display; required |
| `item_count` | `5` | number of recent items to show |
| `thumbnail_image_style` | `thumbnail` | image style for the clickable thumbnail |
| `photoswipe_image_style` | `''` | image style for the PhotoSwipe modal (empty = original) |
| `layout` | `grid` | selected layout plugin id |
| `layout_configuration` | `[]` | layout-plugin-specific config (e.g. `grid_columns`) |
| `view_all_show_link` | `FALSE` | show a "View all" link to `/galleries` |
| `view_all_text` | `View galleries` | link text |
| `view_all_position` | `bottom` | `top`, `bottom`, `left`, `right`, `under_title` |
| `view_all_link_classes` | `button button--primary button--small` | extra CSS classes (class `media-gallery-latest-items-view-all` is always added) |

The block form has a **Layout settings** fieldset with an AJAX layout selector + preview icon, an
**Image Styles** fieldset, and a **View all link** fieldset. Selecting a layout re-renders that
layout's own configuration form (each layout plugin contributes its fields via
`buildConfigurationForm()`). On submit, only the keys in the chosen layout's
`defaultConfiguration()` are stored under `layout_configuration`.

The block build attaches library `media_gallery/media_gallery_block`, adds the class
`media-gallery-layout--<layout>` (and `view-all-position-<pos>`), and merges cache tags
`media_gallery_list` + `media_list` so it invalidates when galleries or media change.

`LatestGalleryItemsBlock` and `GalleryBlock` both query the field table `media_gallery__images`
directly (column `images_target_id`) to collect member media ids, then load published media via an
access-checked entity query sorted by `created DESC`.
