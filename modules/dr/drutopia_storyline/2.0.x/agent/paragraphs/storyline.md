<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Storyline paragraph types, fields and displays

Everything this module does is configuration. No PHP. All files live in `config/install/`.

## Install / enable

`drush en drutopia_storyline -y` imports the config: the two paragraph types, their
field storages/instances, the `field_storyline` node field storage, and the form + view
displays. On disk here it is a **dev checkout** (no `version:` in `info.yml`) and it will
not enable without the full Drutopia dependency chain (`drutopia_core`, `drutopia_page`,
`paragraphs`, `field_group`, `entity_reference_revisions`, `node`, `text`) present — that
is expected in this repo.

## Paragraphs types

- `paragraphs.paragraphs_type.storyline_header.yml` — id `storyline_header`, label
  "Storyline header", empty description, no behavior plugins.
- `paragraphs.paragraphs_type.storyline_item.yml` — id `storyline_item`, label
  "Storyline item", empty description, no behavior plugins.

## Node field: `field_storyline`

`field.storage.node.field_storyline.yml` — `field_name` `field_storyline`, entity type
`node`, type **`entity_reference_revisions`**, `target_type: paragraph`, **cardinality
`-1`** (unlimited), translatable, `persist_with_no_fields: true`. This module ships only
the **storage**; no `field.field.node.<bundle>.field_storyline` instance is included here,
so the field is not attached to any content type by this module alone. (The bundled
companion `drutopia_page_storyline` supplies the instance for the Basic page type.)

## Paragraph fields

| Field | Bundle | Type | Storage / constraints | Notes |
|-------|--------|------|-----------------------|-------|
| `field_storyline_header` | `storyline_header` | `string` | max_length 255, cardinality 1, translatable storage; instance `translatable: false`, `required: false` | Label "Storyline header". Storage `field.storage.paragraph.field_storyline_header` shipped here (module `core`). |
| `field_storyline_heading` | `storyline_item` | `string` | max_length 255, cardinality 1, translatable storage; instance `translatable: false`, `required: false` | Label "Heading". Storage `field.storage.paragraph.field_storyline_heading` shipped here (module `core`). |
| `field_text` | `storyline_item` | `text_long` | instance `required: false`, `translatable: true` | Label "Text". The `field.storage.paragraph.field_text` storage is **not** shipped in this module — it is a reused storage (provided by another Drutopia/text feature); only the instance `field.field.paragraph.storyline_item.field_text` is here (depends on module `text`). |

## Form displays (`core.entity_form_display.paragraph.*.default`)

- **storyline_header** — `field_storyline_header` as `string_textfield` (size 60). `created`,
  `status`, `uid` hidden.
- **storyline_item** — `field_storyline_heading` as `string_textfield` (size 60, weight 0),
  `field_text` as `text_textarea` (rows 5, weight 1). `created`, `status`, `uid` hidden.

## View displays (`core.entity_view_display.paragraph.*.default`)

- **storyline_header** — `field_storyline_header` as `string` formatter, label hidden,
  `link_to_entity: false`. `search_api_excerpt` hidden.
- **storyline_item** — `field_storyline_heading` as `string` (label hidden, weight 1) and
  `field_text` as `text_default` (label hidden, weight 2), both wrapped in a **Field Group**
  (`third_party_settings.field_group.group_storyline_content`): `format_type: html_element`,
  `element: div`, `show_label: false`, `label_element: h3`, label "storyline content",
  children `field_storyline_heading` + `field_text`. `search_api_excerpt` hidden.

## How to operate

1. Enable the module (and its Drutopia dependencies).
2. Attach `field_storyline` to a content type's fields (or enable the bundled companion for
   Basic page), and expose it with the Paragraphs (revisions) widget on the node form.
3. Editors add a `storyline_header` paragraph, then repeatable `storyline_item` paragraphs
   (heading + text), reordering by drag.
4. Adjust the node's display to render `field_storyline`; the bundled paragraph view displays
   theme each entry (heading + grouped text). There is no admin settings form.
