# Templates & theme hooks

`color_field_theme()` registers two theme hooks (in `color_field.module`), each
with a Twig template in `templates/`:

- **`color_field_formatter_swatch`** → `color-field-formatter-swatch.html.twig`
  Variables: `shape`, `color`, `width`, `height`, `attributes`.
- **`color_field_formatter_swatch_option`** → `color-field-formatter-swatch-option.html.twig`
  Variables: `id`, `name`, `input_type`, `value`, `shape`, `color`, `width`,
  `height`, `attributes`.

Override by copying the template into your theme's `templates/` folder.

## CSS libraries
`color_field.libraries.yml` defines swatch CSS (`color-field-formatter-swatch`,
`color-field-formatter-swatch-options`) attached by the formatters, plus the
widget JS/CSS libraries (`color-field-widget-box`, `-spectrum`, `-grid`).
