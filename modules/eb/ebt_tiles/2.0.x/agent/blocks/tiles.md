<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EBT Tiles — block type, Paragraph item, fields, displays, templates

Everything below is defined in `config/install/*.yml` and the `templates/` overrides.
No install hook, no schema files. Enabling the module imports these config entities.

## Block content type `ebt_tiles`

`block_content.type.ebt_tiles.yml` — id `ebt_tiles`, label "EBT Tiles". Fields on the
bundle:

- `body` — `text_with_summary` (`field.field.block_content.ebt_tiles.body`, summary off).
- `field_ebt_settings` — `ebt_settings` field type (owned by **ebt_core**); the shared
  design settings (spacing, background, borders, container width) plus this module's
  extra options (see the widget doc).
- `field_ebt_tiles` — `entity_reference_revisions`, target paragraph, cardinality **-1**
  (`field.storage.block_content.field_ebt_tiles`), handler restricted to
  `target_bundles: ebt_tiles_item`. This is the list of tiles.

Form display (`core.entity_form_display.block_content.ebt_tiles.default`) groups fields
with **field_group** tabs: a *Content* tab (info, body, `field_ebt_tiles` via the
`paragraphs` widget — dropdown add mode, collapse-edit-all + duplicate features) and a
*Settings* tab (`field_ebt_settings` via the **`ebt_settings_tiles`** widget).

View display (`core.entity_view_display.block_content.ebt_tiles.default`): `body`
(text_default), `field_ebt_settings` (ebt_core `ebt_settings_default` formatter),
`field_ebt_tiles` (`entity_reference_revisions_entity_view`, view mode default). Labels
hidden.

## Paragraph type `ebt_tiles_item`

`paragraphs.paragraphs_type.ebt_tiles_item.yml` — id `ebt_tiles_item`, label "EBT Tiles
Item", no behavior plugins. One tile = one paragraph. Fields:

- `field_ebt_tiles_title` — `text_long`.
- `field_ebt_tiles_text` — `text_long`.
- `field_ebt_tiles_image` — `entity_reference` → media, `target_bundles: image`
  (media_library_widget on the form).
- `field_ebt_tiles_link` — core `link` field (`link_type: 17`, i.e. both internal &
  external allowed; title enabled).
- `field_ebt_clickable_tile` — `boolean`, **default value 1** (on). "Make entire tile
  clickable or display link separately if unchecked."

Paragraph view display renders title/text (text_default), image
(entity_reference_entity_view), link (core `link` formatter) and the clickable boolean.

## Templates (`templates/`)

- `block--block-content--ebt-tiles.html.twig` and
  `block--inline-block--ebt-tiles.html.twig` — wrap the block in
  `ebt-block ebt-block-tiles` + a `ebt-tiles-<styles>` class, attach the base
  `ebt_tiles` library plus the per-column library chosen from
  `content.field_ebt_settings['#object'].field_ebt_settings.ebt_settings.styles`
  (`one_column`/`two_columns`/`three_columns`/`four_columns`, default three), print
  `content|without('field_ebt_settings')`, and emit `{{ styles|raw }}` — the `styles`
  variable is the per-block CSS string produced and escaped by **ebt_core** (not by this
  module).
- `field--block-content--field-ebt-tiles--ebt-tiles.html.twig` — standard field wrapper
  adding `ebt-tiles-wrapper`; loops items into `field__item` divs (the grid).
- `paragraph--ebt-tiles-item--default.html.twig` — one tile. When
  `field_ebt_clickable_tile` is on **and** the link renders, wraps the tile inner content
  in `<a href="{{ content.field_ebt_tiles_link.0['#url'] }}" class="ebt-tile">`, adding
  `target="blank"` when `link_in_a_new_tab` and `rel="nofollow"` when `nofollow` (both
  variables set by `preprocessParagraph`, see the widget doc). When off, the link is shown
  as a normal field. Registered via `theme_registry_alter` (base hook `paragraph`).

## Column styles / CSS libraries

`ebt_tiles.libraries.yml` defines `ebt_tiles` (base) + `one_column`, `two_columns`,
`three_columns`, `four_columns`, each a theme CSS file under `css/`. The block template
attaches exactly one column library based on the selected `styles` value.

## Operate it

1. Ensure `ebt_core` and `paragraphs` are enabled and a Media "image" type exists.
2. Enable `ebt_tiles`; the block type + paragraph type + fields/displays are imported.
3. Add a Tiles block via Layout Builder, Block layout, or Content → Blocks. Add tile
   items (title/text/image/link, clickable toggle). Choose the column count and link
   options on the *Settings* tab. Save and place.
