# Configure Linked Field

There is **no central config UI for the linking itself** — you enable linking per field, in
each display's formatter settings. A small admin page configures only the *available link
attributes*.

## Per-field: the "Link this field" formatter setting

At **Structure → Content types → {type} → Manage display** (any entity display), click a
field's formatter settings gear. Linked Field injects these controls (via
`hook_field_formatter_third_party_settings_form()`), stored as **third-party settings** under
the `linked_field` namespace on that display component (so they export with the display config):

| Control | Values | Meaning |
|---|---|---|
| **Link this field** (`linked`) | checkbox (default off) | Turn linking on for this formatter. |
| **Type** (`type`) | `field` or `custom` | Where the href comes from. |
| **Field** (`destination`, when Type=field) | select | Another field on the same entity whose value is the href. |
| **Destination** (`destination`, when Type=custom) | text | A URL/path string; **tokens supported**. |
| **Advanced → attributes** (`advanced.*`) | text per attribute | Link attributes: `title`, `target`, `class`, `rel` by default. Token-replaced; `class`/`rel` merge with existing. |
| **Advanced → Text** (`advanced.text`) | text/token | Link text that **overrides** the field's own output. Leave empty to link the rendered field. |

Notes from source:
- **Field type is disabled for `link`-type fields** (`getFieldTypeBlacklist()` returns `['link']`) — those already render links.
- Only certain field types are offered as a **Field** destination: `link`, `string`, `list_float`, `list_string` (the entity's label field is excluded). If none exist on the bundle, the form forces **Custom**.
- **Custom destinations** accept `/node/1`, `node/1`, or `internal:/node/1`; external URLs need a scheme (e.g. `https://…`). URLs are validated with `Url::fromUri()` unless they contain `[`/`]` tokens (validation is skipped for tokens).
- A **token browser** (`token_tree_link`) appears when the `token` module is enabled, scoped to the field's entity type.
- Empty Linked Field config is stripped on save (won't persist unless `linked` is checked); empty advanced attributes are removed.

Example exported third-party settings on a display component:

```yaml
third_party_settings:
  linked_field:
    linked: 1
    type: custom
    destination: '[node:url]'
    advanced:
      target: _blank
      rel: nofollow
```

## Available link attributes — admin config page

Route `linked_field.config` at **`/admin/config/linked_field/config`** (menu: Config → Content
authoring; permission **`administer linked_field`**). It edits the `linked_field.config`
config object's `attributes` map in **YAML**. Each attribute has an optional `label` and
`description` shown in the Advanced section of every formatter. Default (`config/install/linked_field.config.yml`):

```yaml
attributes:
  title:
    label: ''
    description: ''
  target:
    label: ''
    description: ''
  class:
    label: ''
    description: ''
  rel:
    label: Relationship
    description: ''
```

Add keys here to expose more link attributes site-wide. The form recommends the `yaml_editor`
module for editing but does not require it. Set via drush, e.g.
`drush cset linked_field.config attributes.download.label 'Download'`.

## Permission

`administer linked_field` — "Configure available attributes for linked fields." Gates the
config page above. (Per-field linking is edited by whoever can manage the display, i.e.
`administer {entity} display`.)
