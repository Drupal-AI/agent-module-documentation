<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shipped paragraph type & slide fields

On install the module imports (`config/install/`) an example paragraph type and three fields so the
formatter works out of the box. Nothing here is a settings form — it is installed config you can use,
clone, or ignore in favour of your own paragraph type.

## Paragraph type

- id: `bootstrap_carousel` — label "Bootstrap Carousel" (`paragraphs.paragraphs_type.bootstrap_carousel`).
- No behavior plugins, no icon.

## Fields (bundle `paragraph.bootstrap_carousel`)

| Field | Type | Storage / settings | Role in the formatter |
|---|---|---|---|
| `field_image` | image | cardinality 1, `alt`/`title` enabled, extensions `png gif jpg jpeg`, dir `carousel`, public scheme | The slide image (formatter `image` setting; required). |
| `field_caption` | text_long | cardinality 1 | Optional caption (formatter `caption` setting). |
| `field_link` | link | cardinality 1, `link_type: 17` (generic — internal or external), `title: 1` (title enabled) | Optional click-through URL; its title becomes the caption heading (formatter `link` setting). |

Form display (`core.entity_form_display…default`): `field_image` (`image_image`, thumbnail preview),
`field_caption` (`text_textarea`, 5 rows), `field_link` (`link_default`). View display default renders
the three fields normally — but you normally attach the **carousel formatter** on the *host* field
(see below), not on this paragraph's own display.

## Wire it up

1. Add an `entity_reference_revisions` (Paragraphs) field to your host entity, e.g. `field_slides` on
   a node, allowing the `bootstrap_carousel` bundle (or your own image+caption+link paragraph type).
2. On the host's **Manage display**, set that field's formatter to "Paragraphs boostrap carousel"
   and map image/caption/link — see [../fields/formatter.md](../fields/formatter.md).
3. Editors add slides by adding paragraphs to the field; each paragraph = one carousel slide.

You are not required to use `bootstrap_carousel`; any paragraph type with an image field (plus
optional caption/link fields) works, because the formatter reads whichever fields you map.
