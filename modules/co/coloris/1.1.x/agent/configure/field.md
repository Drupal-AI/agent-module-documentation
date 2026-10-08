# Configure — the Coloris field

No global settings page. You configure Coloris entirely through a `coloris_color` field.

## Add the field

1. *Manage fields* on any bundle → **Add field** → choose **Coloris Color** (`coloris_color`).
2. The default widget is **Color selection** (`text_coloris`) on *Manage form display*; the
   default formatter is **Coloris color** (`coloris_color`) on *Manage display*.
3. Field-level options are edited on the field settings form (`ColorisItem::fieldSettingsForm`).

Storage: one `value` column, `varchar(255)`, but a `Length` constraint caps the stored string at
36 chars (`ColorisItem::getConstraints`).

## Field settings keys

Stored in the field config `settings` (schema `field.field_settings.coloris`):

| Key | Type | Default | Effect |
|---|---|---|---|
| `wrap` | bool | `TRUE` | Wrap the input to show the color thumbnail + accessible button. Off = plain field. |
| `data_theme` | string | `default` | Picker style: `default`, `large`, `polaroid`, `pill`. |
| `theme_mode` | string | `light` | `light`, `dark`, or `Auto`. |
| `margin` | int | `2` | Gap (px) between input and picker dialog. |
| `format` | string | `hex` | Output format: `hex`, `rgb`, `hsl`, `auto`, `mixed`. |
| `format_toggle` | bool | `FALSE` | Show format-toggle buttons in the dialog. |
| `alpha` | bool | `TRUE` | Allow alpha channel (off strips alpha). |
| `force_alpha` | bool | `FALSE` | Always include alpha even at 100% opacity. |
| `swatches_only` | bool | `FALSE` | Hide spectrum/hue; only preset swatches selectable. |
| `focus_input` | bool | `TRUE` | Focus the value input when the dialog opens. |
| `select_input` | bool | `FALSE` | Select+focus the value input on open. |
| `clear_button` | bool | `TRUE` | Show a clear button. |
| `clear_label` | string | `Clear` | Clear button label. |
| `swatches` | array | `[]` | Preset colors (AJAX "Add another item" / "Remove one" builder). |
| `inline` | bool | `FALSE` | Always-visible inline picker instead of on-focus. |
| `default_color` | string | `''` | Default color for inline mode init. |

The swatches sub-form uses AJAX callbacks (`addOne`/`removeCallback`/`addmoreCallback`) and an
`#element_validate` (`validateElement`) that flattens the swatch fieldset back into
`settings['swatches']`.

## Validation & output

- **Input:** `ColorisWidget::validateFormElement` (`src/Element/ColorisWidget.php`) applies a
  strict regex; only `#hex` (3/6/8 hex digits), `rgb()/rgba()`, and `hsl()/hsla()` strings pass,
  else "The color code %color is not valid." Empty is allowed.
- **Formatter** `coloris_color` (`ColorisFormatter`) renders the stored value as `#markup` with
  `FieldFilteredMarkup::allowedTags()`; if the value contains `/` it keeps the part before it.

## Library / CDN

The picker assets come from `coloris/element.coloris` → depends on `element.coloris.lib`, which
loads Coloris CSS+JS from `//cdn.jsdelivr.net/gh/mdbassit/Coloris@latest/...`
(`coloris.libraries.yml`). To self-host or pin a version, override `element.coloris.lib` via
`hook_library_info_alter()` and point it at a local `libraries/` copy.
