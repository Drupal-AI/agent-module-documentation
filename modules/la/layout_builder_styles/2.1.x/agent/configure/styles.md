# Styles and style groups

Two config entity types (schema `config/schema/layout_builder_styles.schema.yml`), managed at
`/admin/config/content/layout_builder_style`. Both are exportable config.

## Style (`layout_builder_styles.style.*`, admin permission `manage layout builder styles`)

| Key | Meaning |
|---|---|
| `id`, `label` | Machine id + human label. |
| `classes` | The CSS class(es) applied when this style is selected (space/newline separated). |
| `type` | Target: `block` or `section`. |
| `group` | Machine id of the style group this belongs to (optional). |
| `block_restrictions` | Sequence of block plugin IDs this style is limited to (empty = all). |
| `layout_restrictions` | Sequence of layout plugin IDs this style is limited to (empty = all). |
| `weight` | Order among styles. |

## Style group (`layout_builder_styles.group.*`)

| Key | Meaning |
|---|---|
| `id`, `label` | Machine id + human label. |
| `multiselect` | Whether multiple styles from the group may be chosen. |
| `form_type` | Widget: e.g. `select`, `checkboxes`/`radios`. |
| `required` | Whether an editor must pick a style. |
| `weight` | Order among groups. |

Grouping styles lets you present a curated selector (e.g. one "Background color" dropdown)
instead of many independent checkboxes. Add styles/groups from the collection page's action
links (`entity.layout_builder_style.add_form`, `entity.layout_builder_style_group.add_form`).
