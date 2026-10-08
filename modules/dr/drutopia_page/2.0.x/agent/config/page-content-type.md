<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Page content type, fields, form display, and view displays

All items below are YAML in `config/install/`. This is a config feature installed via the
Drutopia distribution (`composer require drupal/drutopia_page` then enable, or install the
distribution). Enabling imports the config; no code runs.

## Node type — `node.type.page.yml`

- `type: page`, name **Page**, description "Use *pages* for your static content, such as an
  'About us' page."
- `new_revision: true`, `preview_mode: 1` (optional preview), `display_submitted: false`.
- `third_party_settings.menu_ui`: available menus **footer** and **main**, default parent `main:`
  (pages can be placed in the main/footer menu from the node form).

## Fields (`field.field.node.page.*.yml`)

Four fields on the `page` bundle. **No field storages are shipped by this module** — all storages
(`field.storage.node.*`) come from core / Drutopia dependencies.

| Field name | Label | Type | Notes |
|---|---|---|---|
| `field_summary` | Summary | text_long | **required**; "Enter a short description… visible in search results." |
| `field_body_paragraph` | Description | entity_reference_revisions | → paragraphs: **text, image, file, video, slide, update, faq** (all seven enabled). |
| `field_meta_tags` | Meta tags | metatag | default value `a:0:{}`. |
| `body` | Body | text_with_summary | `display_summary: true`, but **hidden in the form and every view display** (see below). |

The seven paragraph types (`paragraphs.paragraphs_type.{text,image,file,video,slide,update,faq}`)
are referenced as config dependencies but are provided by Drutopia dependencies, not shipped here.

## Form display — `core.entity_form_display.node.page.default.yml`

Single `default` form display. Visible widgets: `field_summary` (text_textarea, 5 rows, weight 1),
`field_body_paragraph` (`entity_reference_paragraphs` widget, edit_mode `open`, add_mode `button`,
default paragraph type **text**, weight 2), `field_meta_tags` (`metatag_firehose`), plus core
`title`, `uid`, `created`, `status`, `path`, and `url_redirects`. **Hidden:** `body`, `promote`,
`sticky`. So editors build page content from the Summary field and the Paragraphs builder, not the
core body field.

## View displays (view modes) — `core.entity_view_display.node.page.*.yml`

All three use the Display Suite (`ds`) `ds_1col` one-column layout.

- **default** — empty `content`; every field is hidden (`body`, `field_body_paragraph`,
  `field_meta_tags`, `field_summary`, `links`, `search_api_excerpt`). Layout only.
- **full** — DS `ds_content` region renders `field_body_paragraph`
  (`entity_reference_revisions_entity_view`, label hidden, default view mode) followed by `links`.
  `body`, `field_meta_tags`, `field_summary` hidden. This is the main page render.
- **teaser** — DS `ds_content` region shows the DS `node_title` field (linked, wrapped in `h2`,
  label hidden) then `field_summary` (`text_default`). Other fields hidden.

All formatters are standard core/DS/entity_reference_revisions display formatters
(`entity_reference_revisions_entity_view`, `text_default`, DS `node_title`). Nothing renders raw
user or remote markup, and no `|raw`/full-HTML formatter is configured here.
