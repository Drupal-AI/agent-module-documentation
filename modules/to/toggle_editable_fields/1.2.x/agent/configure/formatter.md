# Configure the Toggle Editable formatter

The module adds **one** formatter, id `toggle_editable_formatter`
(`src/Plugin/Field/FieldFormatter/ToggleEditableFormatter.php`), restricted to
`field_types = { boolean }`. There is no admin settings page — you configure it per field on a
display.

## Prerequisites

- Enable `toggle_editable_fields` (pulls in `field`, `field_ui`, `libraries`).
- Install the Bootstrap Toggle library so its JS/CSS resolve. `hook_requirements`
  (`toggle_editable_fields.install`) emits a **warning** (not an error) if
  `/libraries/bootstrap-toggle/js/bootstrap-toggle.min.js` (or the same path under the active
  install profile) is missing. Library id used by the formatter: `toggle_editable_fields/bootstrap.toggle`.

## Apply it

1. Have (or add) a **Boolean** field on an entity bundle.
2. Go to *Manage display* for that bundle (`entity.entity_view_display.{entity}.default`) — or add
   the field to a **View** as a field.
3. Set the field's format to **"Toggle Editable Formatter"** and open its settings.

Equivalent config lives in the view/form display entity under
`content.{field}.settings` and validates against schema
`field.formatter.settings.toggle_editable_formatter` (`config/schema/…`).

## Settings keys (defaults from `defaultSettings()`)

| Key | Type | Default | Notes |
|---|---|---|---|
| `on` | string | `On` | Custom label shown in the "on" state |
| `off` | string | `Off` | Custom label shown in the "off" state |
| `size` | select | `small` | `large` \| `normal` \| `small` \| `mini` |
| `onstyle` | select | `success` | `default`\|`primary`\|`success`\|`info`\|`warning`\|`danger` |
| `offstyle` | select | `default` | same option set as `onstyle` |
| `height` | int | `null` | pixel override, min 1; blank = library default |
| `width` | int | `null` | pixel override, min 1; blank = library default |

All non-null settings are passed straight through to the checkbox as `data-{key}` attributes
(`setBootstrapDataAttributes()`), which the Bootstrap Toggle JS reads to render the switch. The
formatter's settings summary echoes each chosen value.

## Rendered result

For each field item, `viewElements()` builds an `AjaxToggleForm` (via the class resolver, so the
form id is made unique per entity/field/delta) and renders it. The switch's checked state
mirrors the stored boolean; flipping it saves the entity (see
[../extend/save-path.md](../extend/save-path.md)). The switch is **disabled** for users who lack
edit access to the field/entity.
