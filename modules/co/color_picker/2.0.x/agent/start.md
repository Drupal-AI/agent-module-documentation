# Color Picker — agent index

One Form API render element (`#type => 'color_picker'`): a hex-color text input with a JS/CSS
swatch widget. No admin UI, no config, no permissions, no field type, no Drush. Pure Forms API
building block for custom code.

- **The element, its properties, `#color_values`, and value/attribute handling** →
  [api/element.md](api/element.md)

Key facts:
- Class `Drupal\color_picker\Element\ColorPicker` (`@FormElement("color_picker")`), extends core
  `FormElement`. Text input, `#pattern` `#([A-Fa-f0-9]{6})`, `#size`/`#maxlength` 7.
- Attaches library `color_picker/color_picker` (core/jquery + core/drupal + core/once + own JS/CSS).
- `#color_values` (comma-separated hex list) → `preRenderColorPicker()` puts it on the input as
  `color_values`, then `color_picker_preprocess_color_picker()` renames to `data-color-values`
  for the JS.
- Theme hook `color_picker` → `templates/color-picker.html.twig` (`.color-picker` wrapper +
  `.color-values` div).
