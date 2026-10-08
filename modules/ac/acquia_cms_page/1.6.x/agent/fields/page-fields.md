<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fields on the Page (`node.page`) content type

The module ships two of its own field storages and reuses three shared Acquia CMS field storages
(`body`, `field_categories`, `field_tags` come from core/`acquia_cms_common`). All field instances
carry `dependencies.enforced.module: [acquia_cms_page]`.

| Field (machine name) | Label | Type | Target / storage | Form widget | Cardinality |
|---|---|---|---|---|---|
| `body` | Body | `text_with_summary` (reused `field.storage.node.body`) | — | `text_textarea_with_summary` (9 rows, summary hidden) | 1 |
| `field_categories` | Categories | `entity_reference` (reused) | taxonomy_term, bundle `categories` | `options_select` | unlimited (storage) |
| `field_tags` | Tags | `entity_reference` (reused) | taxonomy_term, bundle `tags`, `auto_create: true` | `entity_reference_autocomplete_tags` | unlimited (storage) |
| `field_page_image` | Image | `entity_reference` → **media** (own `field.storage.node.field_page_image`) | media bundle `image` | `media_library_widget` | 1 |
| `field_layout_canvas` | Layout Canvas | `cohesion_entity_reference_revisions` → `cohesion_layout` (own storage) | — (managed by Site Studio) | — | 1 |

## Notes per field

- **`body`** — `display_summary: false`. Its label is changed to **"Search Description"** (with a
  matching description) at runtime *if* `acquia_cms_site_studio` is installed — see
  [../hooks/hooks.md](../hooks/hooks.md) (`acquia_cms_page_modules_installed`). In that Site Studio
  setup the visible page layout is built with Layout Canvas, and Body becomes a search-only teaser.
- **`field_page_image`** — description "An image which will be displayed in search results." Own
  storage: `entity_reference`, `target_type: media`, `translatable: true`, `cardinality: 1`. Rendered
  in view modes via `entity_reference_entity_view` at referenced media view modes
  (`large_super_landscape` / `small_landscape` / `teaser` depending on the display).
- **`field_layout_canvas`** — only installed when Site Studio is present; its storage and instance
  enforce both `acquia_cms_page` and `acquia_cms_site_studio` and pull in `cohesion_elements`. Not
  listed in the shipped default form/view displays (Site Studio provides its own canvas editing UI).
- **`field_categories` / `field_tags`** — reference the shared `categories` and `tags` vocabularies
  provided by the wider Acquia CMS content model (`acquia_cms_common`); `field_tags` auto-creates
  terms.

To add a field, use the normal Field UI / config on the `page` bundle; nothing here is special beyond
the enforced-module dependency (which keeps the fields tied to this module's lifecycle).
