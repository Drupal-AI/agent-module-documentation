<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the EPT Image Gallery paragraph

No module settings page (`configure` is null). Everything ships as installed config; you
configure a gallery per paragraph instance and, optionally, per entity-display component.

## What installing creates (config/install)

| Config | What it is |
|---|---|
| `paragraphs.paragraphs_type.ept_image_gallery` | The `ept_image_gallery` Paragraphs type. |
| `field.storage.paragraph.field_ept_image_gallery` | `entity_reference` → `media`, cardinality `-1` (unlimited). |
| `field.field.paragraph.ept_image_gallery.field_ept_image_gallery` | Gallery images field instance. |
| `field.field.paragraph.ept_image_gallery.field_ept_{title,text,settings}` | Title, body text, and the shared EPT settings field. |
| `core.entity_form_display.paragraph.ept_image_gallery.default` | Uses widget `ept_settings_image_gallery` on `field_ept_settings`. |
| `core.entity_view_display.paragraph.ept_image_gallery.default` | Renders `field_ept_image_gallery` with `entity_reference_entity_view` in the `ept_image_gallery` media view mode. |
| `core.entity_view_mode.media.ept_image_gallery` + `core.entity_view_display.media.image.ept_image_gallery` | Media "image" view mode whose `field_media_image` uses the **`glightbox`** formatter. |
| `image.style.ept_gallery_image` | Image style, `image_scale_and_crop` to 365×265, center anchor. |

## The Styles setting (per paragraph instance)

The form widget `ept_settings_image_gallery` (class `EptSettingsImageGalleryWidget`, extends
`ept_core`'s `EptSettingsDefaultWidget`) adds a **Styles** radio to the paragraph edit form,
stored under `field_ept_settings.ept_settings.styles`:

| Value | Layout |
|---|---|
| `one_column` / `two_columns` / `three_columns` / `four_columns` / `five_columns` | N equal columns (default `four_columns`). |
| `fixed_size_image` | Fixed-size images grid. |
| `fluid_grid` | Fluid grid. |
| `featured_images_grid` | Featured images grid (emphasise first images). |

The chosen value is added verbatim as a CSS class on the paragraph wrapper (see
[theming/templates.md](../theming/templates.md)). The widget also forces
`ept_settings.pass_options_to_javascript = FALSE` (this paragraph type needs no JS options).
Other EPT settings (title wrapper/strip-tags, design options, spacing) come from the shared
`ept_core` settings trait/widget.

## GLightbox display

`field_media_image` in the `media.image.ept_image_gallery` view mode uses formatter `glightbox`
with: `glightbox_node_style: ept_gallery_image` (thumbnail style), `glightbox_gallery: parent`
(all items in the paragraph share one lightbox gallery), `glightbox_caption: auto`. Change these
on *Manage display* of the Image media type's `ept_image_gallery` view mode to alter thumbnail
size, caption source, or lightbox grouping.

## Add a gallery to your content

1. Ensure the host entity has a Paragraphs reference field that allows the `ept_image_gallery`
   type (Structure → Content type → add an *Entity reference revisions* / Paragraphs field, or
   reuse an existing one).
2. Edit content, add an **EPT Image Gallery** paragraph.
3. In `field_ept_image_gallery`, select/upload one or more **Image** media items.
4. Optionally fill Title/Text, and pick a **Styles** layout.
5. Save — thumbnails render in the chosen grid and open in GLightbox.

Global colors and mobile/tablet/desktop breakpoints are shared across EPT paragraphs and edited
at EPT Core's settings (`admin/config/content/ept-core`, config `ept_core.settings`).
