# Paragraph types & fields

All defined as config entities in `config/optional/` (installed as *optional* config, so they
only import when their dependencies are met). The base module ships **three** paragraph types
and **one** media type; the 23 submodules add more bundles that reuse the same field pattern.

## Paragraph types

| id | label | purpose |
|----|-------|---------|
| `w3css_simple` | Simple | Text/link block: title + body + link + the full W3.CSS display option set (incl. the free-text classes field). |
| `w3css_image`  | Image  | Image (media reference) + optional wrapping link + display options. No body, no free-text classes field. |
| `w3css_shared` | w3css Shared | Reusable **layout container**: left/middle/right column reference fields (each holds child paragraphs) plus tab/accordion state fields. Reused by the column, tabs and accordion submodules. |

## Fields — `w3css_simple`

Field storages are all bundle-shareable (prefix `w3css_`). `list_string` fields expose fixed
allowed-value lists (W3.CSS option sets); the template turns the selected value into a CSS class.

| field | type | label | notes |
|-------|------|-------|-------|
| `w3css_content_title` | string(255) | Content Title | rendered in an `<h3 class="content-title">` |
| `w3css_content_body` | text_long | Content Body | rendered through its text format |
| `w3css_content_link` | link | Link | href on an anchor; standard core link field validation |
| `w3css_content_link_title_attr` | string | Link Title Attribute | emitted as the anchor `title=""` |
| `w3css_display_bg_color` | list_string | Background Colors | `w3-*` color → inline `rgba()` background |
| `w3css_display_opacity` | list_string | Background Color Opacity | multiplies the bg color alpha |
| `w3css_display_hover_bg` | list_string | Background Color Hover | added as class |
| `w3css_display_text_color` | list_string | Text Colors | added as class |
| `w3css_display_hover_text` | list_string | Text Color Hover | added as class |
| `w3css_display_border` | list_string | Adding Borders | added as class |
| `w3css_display_border_color` | list_string | Border Colors | added as class |
| `w3css_display_hover_border` | list_string | Border Color Hover | added as class |
| `w3css_display_card` | list_string | Card | `w3-card-*` shadow, added as class |
| `w3css_display_round` | list_string | Round Corners | added as class |
| `w3css_display_margin` | list_string | Margin | applied to inner child wrapper |
| `w3css_display_padding` | list_string | Padding | applied to inner child wrapper |
| `w3css_display_width` | list_string | Width | `p-container-width-*` on container |
| `w3css_display_classes` | string(255) | W3.css Classes | **free text**; space-separated extra class names merged onto the container |

## Fields — `w3css_image`

Same `w3css_display_*` option set as `w3css_simple` **except** it has **no** `w3css_content_body`
and **no** `w3css_display_classes`. Plus:

| field | type | label | notes |
|-------|------|-------|-------|
| `w3css_content_image` | entity_reference → media (`w3css_media_image`), cardinality 1 | Image | the displayed image |
| `w3css_content_title` | string(255) | Content Title | |
| `w3css_content_link` | link | Link | wraps the image in an anchor when set |
| `w3css_content_link_title_attr` | string | Link Title Attribute | anchor `title=""` |

## Fields — `w3css_shared`

| field | type | notes |
|-------|------|-------|
| `w3css_content_left_column` | entity_reference_revisions → paragraph, cardinality -1 | child paragraphs |
| `w3css_content_middle_column` | entity_reference_revisions → paragraph, cardinality -1 | child paragraphs |
| `w3css_content_right_column` | entity_reference_revisions → paragraph, cardinality -1 | child paragraphs |
| `w3css_display_active_item` | list_string | which tab/item is active |
| `w3css_display_animated_tab` | list_string | tab animation class |

## Media type

`w3css_media_image` (label "W3CSS Image", source `image`) with dedicated form mode
`w3css_media_form_image` and view mode `w3css_media_view_image`. The `w3css_image` bundle
references this media type.

## Submodules (not documented here)

The tarball ships 23 submodules, each adding one component bundle (and, where noted, requiring
an extra contrib module). Enable only the ones you need:

`w3css_paragraphs_3d_carousel`, `w3css_paragraphs_3d_flip_box`, `w3css_paragraphs_accordion`,
`w3css_paragraphs_block` (Drupal Block), `w3css_paragraphs_card`,
`w3css_paragraphs_contact_form` (needs `contact_formatter`), `w3css_paragraphs_content`,
`w3css_paragraphs_custom_block`, `w3css_paragraphs_hero`,
`w3css_paragraphs_hero_full_width` (needs `w3css_paragraphs_responsive_image` + `w3css_paragraphs_content`),
`w3css_paragraphs_image_overlay`, `w3css_paragraphs_menu` (needs `menu_reference_render`),
`w3css_paragraphs_modal`, `w3css_paragraphs_one_column`, `w3css_paragraphs_parallax`,
`w3css_paragraphs_quicklinks` (needs `link_attributes`), `w3css_paragraphs_responsive_image`,
`w3css_paragraphs_slideshow`, `w3css_paragraphs_tabs`, `w3css_paragraphs_three_columns`,
`w3css_paragraphs_two_columns`, `w3css_paragraphs_views` (needs `viewsreference`),
`w3css_paragraphs_webform` (needs `webform`).
