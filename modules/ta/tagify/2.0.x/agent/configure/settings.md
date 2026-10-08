# Configuration

## Global settings
Config object `tagify.settings` (schema `config/schema/tagify.schema.yml`), form
`tagify.settings` at `/admin/config/tagify/settings` (permission: `administer site
configuration`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `set_default_widget` | bool | FALSE | Make Tagify the default widget for every entity-reference field type. |

## Per-field widget settings
Two field widgets are provided; set them on the field's *Manage form display* tab.

- `tagify_entity_reference_autocomplete_widget` — autocomplete + chips.
- `tagify_select_widget` — Tagify-styled select for option lists.

Autocomplete widget settings (defaults from `defaultSettings()`):

| Key | Default | Meaning |
|---|---|---|
| `match_operator` | `CONTAINS` | Autocomplete matching mode (`CONTAINS` or `STARTS_WITH`). |
| `match_limit` | 10 | Max suggestions in the dropdown (0 = unlimited). |
| `suggestions_dropdown` | on first character | When the dropdown opens. |
| `placeholder` | '' | Placeholder text in the empty field. |
| `show_entity_id` | 0 | Include the entity ID within each tag. |
| `show_info_label` | 0 | Show an extra info label beside suggestions. |
| `info_label` | '' | Token-enabled string for the info label (e.g. `[term:description]`). |
| `parent_selection` | 1 | Allow selecting parent terms in hierarchical vocabularies. |

The select widget shares `match_operator`, `match_limit`, `placeholder`,
`show_entity_id`, `parent_selection`, `cardinality`, `identifier`.

Config is exportable YAML under `field.widget.settings.tagify_*`.
