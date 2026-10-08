<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Slide fields (Hero slider content type)

Three fields ship on the `varbase_heroslider_media` node bundle (recipe config under
`recipes/default/config/`), plus the node `title`. All are cardinality 1.

| Field | Type | Label | Required | Storage |
| --- | --- | --- | --- | --- |
| `field_media_single` | `entity_reference` → `media` | "Slide media (image/video)" | **yes** | `field.storage.node.field_media_single` (target_type `media`) |
| `field_brief` | `string_long` | "Slide text" | no | `field.storage.node.field_brief` (core string_long, translatable) |
| `field_link` | `link` | "Call for action link" | no | `field.storage.node.field_link` |

## `field_media_single` (the slide's media)

- Handler `default:media`; **target bundles**: `image`, `remote_video`, `video`
  (`auto_create: false`). So a slide is one image, one uploaded video, or one remote
  (YouTube/Vimeo) video.
- **Form widget**: `media_library_widget` (Media Library), with `media_library_edit` enabled
  (`show_edit: 1`).
- **View display** (`node…default`): `entity_reference_entity_view` rendering the referenced media
  in the **`varbase_media_hero_slider`** view mode. Per media bundle that view mode is configured
  in `recipes/default/config/core.entity_view_display.media.{image,remote_video,video}.varbase_media_hero_slider.yml`:
  - image → `drimage_improved` formatter (responsive, 16:9 aspect ratio, lazy).
  - remote_video → `varbase_oembed` formatter.
  - video → core `file_video` (controls, playsinline, muted-capable).
  - All wrapped by Display Suite with class `vw-100 varbase-video-player ratio ratio-16x9`.

## `field_brief` (slide text)

- `string_long` (plain long text — **not** a formatted/`text_long` field, so no text format /
  WYSIWYG). Rendered with the **`basic_string`** formatter (plain text, escaped) on the node view
  display, and in the view the field is also `basic_string` then wrapped by a rewrite template
  `<div class="slick__text">{{ field_brief }}</div>`.
- Form widget `string_textarea` (5 rows). Editor aids: **Maxlength** JS soft limit 300 chars,
  **Length Indicator** (optimin 10 / optimax 15), and an `advanced_text_formatter` third-party
  setting (`show_token_tree: 0`). (Node `title` similarly has Maxlength + Length Indicator.)

## `field_link` (call-to-action)

- Core `link` field. Field config: `link_type: 17` (both internal + external allowed) and
  `title: 2` (link text **required**).
- Form widget `link_default`; view formatter `link` (trim 80, not url-only).
- The view passes `field_link` as the Slick caption/link (`link: field_link` in the style options).

## Editing flow

Node-add form (`node/add/varbase_heroslider_media`) groups title, slide text, media and link into a
single **"Slide information"** fieldset (field_group). After saving, add the slide to the
**Media Hero Slider** entityqueue so it appears in the slider — see
[../configure/media-hero-slider.md](../configure/media-hero-slider.md).
