<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content List: bundle, extend rows, template

Config-only submodule (`.module` is empty). Everything is installed config plus one theme
template.

## Widget bundle

- `stacks.widget_entity_type.contentlist` — `plugin: default_widget` (no custom PHP; plain
  field-to-template rendering).
- Key field **`field_clist_content`** on the `contentlist` `widget_entity` bundle: an
  entity-reference to `widget_extend` entities, edited inline (Inline Entity Form). Add any
  other fields you want; they pass to the template as `{{ fields.field_x }}`.

## Widget Extend row bundles (installed)

Rows are `widget_extend` entities; each row's bundle decides its fields:

| `widget_extend_type` bundle | fields |
|-----------------------------|--------|
| `link` | `field_extend_link_url` |
| `media_or_file` | `field_extend_description`, `field_extend_file_upload` |

Add more bundles at `/admin/structure/stacks/widget_extend_type` for extra row options; add
fields to them via Field UI. The content list widget's reference field can offer any of
these bundles, so a single list may mix row types.

## Template (author in theme)

`stacks/contentlist/templates/contentlist--default.html.twig` — iterate the referenced
`widget_extend` rows and branch on each row's bundle (`link` vs `media_or_file` vs your
own) to emit the desired markup. A `default` variation is required; add more variations as
`contentlist--<variation>.html.twig`.

## Setup

1. Enable `stacks_content_list` (pulls in `stacks_content_feed`).
2. In the Stacks field's Manage form display, enable the **Content List** widget type.
3. Copy `stacks/contentlist/` from the module into your theme's `stacks/` dir; clear cache.
4. (Optional) add row bundles/fields, then account for them in the template.
