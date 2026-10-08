<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Person content type — fields, form display, view displays, and the .install hook

All items are shipped config under `config/install/`. Enabling the module imports them. This is a
config feature normally installed via the Drutopia distribution.

## Node type — `node.type.people.yml`

- `type: people`, `name: Person`, `new_revision: true`, `preview_mode: 1`, `display_submitted: false`.
- Depends on `menu_ui`; `third_party_settings.menu_ui` enables the `main` menu (`parent: 'main:'`),
  so profiles can be placed in the main menu.
- Description: "Use the *person* content type for people such as staff, volunteers, contributors."

## Base field overrides

- `core.base_field_override.node.people.title.yml` — the node **title** is relabelled **"Name"**
  and stays required.
- `core.base_field_override.node.people.promote.yml` — "Promoted to front page" boolean, default
  `0` (off).

## Fields (`field.field.node.people.*` + `field.storage.node.*`)

| Field | Label | Type | Required | Notes |
|---|---|---|---|---|
| `title` (base) | Name | string | yes | relabelled from Title |
| `field_summary` | Summary | text_long | **yes** | short description shown on teasers/listing |
| `body` | Body | text_with_summary | no | `display_summary: true` |
| `field_body_paragraph` | Bio | entity_reference_revisions (paragraph) | no | target bundles: file, image, text |
| `field_media_image` | Media image | entity_reference_entity_modify (media) | no | image bundle; `media_library_media_modify` widget |
| `field_people_position` | Position or job title | string (max 255) | no | storage `field_people_position` |
| `field_people_type` | People type | entity_reference (taxonomy_term) | no | target vocab `people_type`; storage `field_people_type` |
| `field_topics` | Topics | entity_reference (taxonomy_term) | no | target vocab `topics` (from a Drutopia dependency), sorted by name |
| `field_meta_tags` | Meta tags | metatag | no | per-node SEO metadata |

- `field.storage.node.field_authors.yml` — a **multi-value** (`cardinality: -1`) node→node
  entity_reference storage named `field_authors`. The people module ships this **storage** (the
  reference other content types use to credit a person); the actual `field_authors` *field
  instances* live on those other bundles, not on `people`. It is the source for the
  content-by-author view.

## Form display — `core.entity_form_display.node.people.default.yml`

Widgets: `field_body_paragraph` = entity_reference_paragraphs (default paragraph type `text`),
`field_media_image` = media_library_media_modify_widget, `field_meta_tags` = metatag_firehose,
`field_people_position` = string_textfield, `field_people_type` = options_select, `field_summary`
= text_textarea, `field_topics` = options_select, plus core created/path/promote/sticky widgets.

## View displays (seven, `core.entity_view_display.node.people.*`)

`default`, `full`, `teaser`, `card`, `simple_card`, `small_card`, and `search_index`. The
`teaser` display is what the people listing view renders; `search_index` is the display fed to the
Search API index and is the display the features file marks `required`. The card variants
(card / simple_card / small_card) are theme-oriented profile cards. These displays use Display
Suite (`ds`) and Field Group layouts.

## The `.install` file — `drutopia_people.install`

- Contains **no `hook_install`** and **no insecure default logic**.
- One update hook: **`drutopia_people_update_8201()`** calls
  `\Drupal::service('module_installer')->install(['views_plain'])` to add the `views_plain`
  dependency for existing sites. That is the entirety of the module's executable code.
