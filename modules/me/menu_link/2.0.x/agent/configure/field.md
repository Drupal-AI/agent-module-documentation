# Configure — the `menu_link` field, widget & formatters

Configuration is entirely per-field via Field UI (Manage fields / form display / display). There is
no module settings page.

## Add the field
1. On a bundle → **Manage fields → Add field → General → "Menu link"** (field type `menu_link`).
2. Cardinality is locked to 1 (the module hides the cardinality control on the storage form).
3. Configure field settings (below), then place the widget on **Manage form display** and a
   formatter on **Manage display**.

## Field type `menu_link`
Columns stored in a fixed table: `menu_name` (varchar 255), `title` (varchar 255),
`description` (big blob), `parent` (varchar 255), `weight` (int). Properties of the same names.
`preSave`/`doSave` create or update a `MenuLinkField` menu-link plugin so the link appears in the
menu; `delete()` removes the plugin definition.

## Storage settings
| Key | Default | Meaning |
|---|---|---|
| `menu_link_per_translation` | `FALSE` | Expose a separate menu link per content translation. |

## Field (instance) settings
| Key | Default | Meaning |
|---|---|---|
| `available_menus` | `['main']` | Checkbox list of menus a link on this bundle may be placed in. Required. |
| `default_menu_parent` | `'main:'` | Default `menu:parent` selection for new links (must be one of the available menus). |

## Widget `menu_link_default`
Renders a "Menu settings"-style sub-form: `title` (textfield), `description` (textarea, shown on
hover), and a **menu parent selector** (core `menu.parent_form_selector`) limited to
`available_menus`; weight is stored from the selected placement. Also usable on the field's
"Default value" form. On node types this widget replaces core Menu module's node-form section.

## Formatters
- **`menu_link`** — renders the stored link. Setting `link_to_target` (default `TRUE`): when on,
  outputs a hyperlink to the target entity/URL; when off, renders the title as plain (escaped) text.
- **`menu_link_breadcrumb`** — renders the menu ancestry of the link as a breadcrumb. Settings:
  `link_to_target` (link the crumbs) and `parents_only` (show only ancestors, excluding the link
  itself).

## Config schema keys (for config imports)
`field.storage_settings.menu_link`, `field.field_settings.menu_link`,
`field.formatter.settings.menu_link`, `field.formatter.settings.menu_link_breadcrumb`,
`field.value.menu_link` (default value: `menu_name`, `parent`, `weight`).
