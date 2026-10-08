Color Picker provides a single Form API render element (`#type => 'color_picker'`) — a text input constrained to 6-digit hex colors with an attached JS/CSS library that renders selectable color swatches from a supplied list.

---

The module defines one element class, `Drupal\color_picker\Element\ColorPicker` (`@FormElement("color_picker")`), extending core's `FormElement`. It is a text input (`#size`/`#maxlength` 7, `#pattern` `#([A-Fa-f0-9]{6})`) that attaches the `color_picker/color_picker` library (jQuery + Drupal + once, plus `js/color_picker.js` and `css/color_picker.css`) and themes via the `color_picker` theme hook (`templates/color-picker.html.twig`, which wraps the input in `.color-picker` with a `.color-values` div). You pass a comma-separated list of hex codes in `#color_values`; `preRenderColorPicker()` copies it onto the input as a `color_values` attribute, and `color_picker_preprocess_color_picker()` renames it to the `data-color-values` attribute that the JS reads to build the swatches. There is no admin UI, no config, no permissions, and no field type — it is purely a building block for custom forms (or other modules) that need a color-selection widget. Value handling is standard text-input behavior; the picker just assists entry.

---

- Add a hex color selection field to a custom configuration or settings form.
- Offer editors a fixed palette of brand colors to choose from via swatches.
- Collect a background/foreground color in a module's admin form with validation to 6-hex-digit values.
- Provide a color input in a multistep form or block configuration.
- Reuse a consistent color-picker widget across several custom forms.
- Constrain color entry to a curated set of `#color_values` rather than free-form input.
- Build a theme-settings option where a site builder picks an accent color.
- Capture a color for a custom entity field through a Form API element.
- Give a "pick a label color" control in a taxonomy or tagging UI.
- Add a swatch picker to a Layout Builder or paragraph settings form.
- Prototype a color-driven feature without writing a bespoke JS widget.
- Standardize hex-color inputs (pattern-validated) across a project's admin forms.
- Let another custom module embed a swatch picker without shipping its own JS/CSS.
- Provide a color control in a webform-adjacent custom element or settings page.
- Offer a limited accent-color choice in a component/design-token editing UI.
- Add a per-item color to a manual-ordering or tagging admin screen.
- Capture a highlight color for a call-to-action block in block config.
