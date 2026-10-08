# Configure the Select2 field widgets

Select2 has **no global settings form** (`configure` is null). You configure it per field, on
the entity's **Manage form display** page, by choosing a Select2 widget.

## Two widgets

| Widget id | Class | Field types | For |
|---|---|---|---|
| `select2` | `Select2Widget` | `list_integer`, `list_float`, `list_string` | List (allowed-values) select fields |
| `select2_entity_reference` | `Select2EntityReferenceWidget` (extends `Select2Widget`) | `entity_reference` | Reference fields, adds autocomplete + autocreate |

Set via **Structure → (content type) → Manage form display**, or in `core.entity_form_display.*`
config: `content.<field>.type: select2_entity_reference`.

## `select2` widget settings

| Setting | Default | Meaning |
|---|---|---|
| `width` | `'100%'` | Container width — any CSS value (`500px`, `50%`), or `element` / `computedstyle` / `style` / `resolve` |

## `select2_entity_reference` widget settings (adds to the above)

| Setting | Default | Meaning |
|---|---|---|
| `autocomplete` | `false` | Lazy-load options over AJAX instead of rendering them. Recommended for large lists. |
| `match_operator` | `'CONTAINS'` | Autocomplete matching: `STARTS_WITH` or `CONTAINS` (Contains is heavier on big datasets) |
| `match_limit` | `10` | Max suggestions returned; `0` = unlimited |

`match_operator` / `match_limit` only apply when `autocomplete` is on.

## Autocomplete + "create new" (tags)

- **Autocomplete**: enable the `autocomplete` widget setting. Options are fetched from the
  `select2.entity_autocomplete` route as you type (min input length 1, 250ms debounce).
- **Autocreate / tags**: this is driven by the **entity reference field's own** selection-handler
  setting *"Create referenced entities if they don't already exist"* (`auto_create`, plus
  `auto_create_bundle` when the field targets multiple bundles). When enabled, the Select2 widget
  turns on Select2 `tags` mode — typing a label that doesn't exist creates the entity on save
  (unsaved until the host entity is saved), with `,` as a token separator. No separate widget
  setting is needed; it follows the field's handler configuration.

Config schema: `config/schema/select2.schema.yml`
(`field.widget.settings.select2`, `field.widget.settings.select2_entity_reference`). Settings
export/deploy with `drush config:export`.
