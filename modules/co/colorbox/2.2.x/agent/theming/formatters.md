# Colorbox field formatters & theme hooks

Assign these under **Manage display** (`entity.entity_view_display.*`) for a field.

## Field formatters (core `FieldFormatter` plugin type — Colorbox does not define new plugin types)
| Formatter id | Class | For |
|---|---|---|
| `colorbox` | `ColorboxFormatter` | image fields → lightbox |
| `colorbox_responsive` | `ColorboxResponsiveFormatter` | image fields using a responsive image style |
| `colorbox_view_modes` | `ColorboxEntityReferenceFormatter` | entity-reference fields → referenced entity view mode in a modal |

Formatter settings include image style (trigger), the lightbox image style / responsive style,
gallery grouping (per field / per post / custom token), and caption source.

## Theme hooks (`hook_theme()` in `colorbox.module`, templates in `colorbox.theme.inc`)
- `colorbox_formatter` — vars: `item`, `item_attributes`, `entity`, `settings`
- `colorbox_responsive_formatter` — same vars, responsive image
- `colorbox_view_mode_formatter` — vars add `content`, `modal`, `field_name`

Override by implementing `THEME_colorbox_formatter()` / providing a matching template, or
preprocess via `hook_preprocess_colorbox_formatter()`.

## Styles / libraries (`colorbox.libraries.yml`)
Bundled visual styles: `default`, `plain`, `stockholmsyndrome`, plus `example1`–`example5`
from the JS library. Selected by the `custom.style` setting. To add your own style, copy a
style folder into your theme and set the style to `none` (see help text).
