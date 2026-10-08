Color pickr adds a dedicated color field type (`color_pickr_code`) with a JavaScript color-picker widget (bundling the [Pickr](https://github.com/Simonwep/pickr) library) and five display formatters that render the stored color as a text label or a colored swatch (default, square, circle, hexagon, line).

---

The module ships one field type, `color_pickr_code`, that stores a single color string (varchar 256) per value. Its default widget `color_pickr_default` renders a read-only textfield plus a `<div class="color-picker">` that the bundled Pickr library (`js/pickr.min.js` + `js/color_pickr.js`) turns into an interactive swatch/hex/rgba/hsla/cmyk picker; the widget has two settings — `theme` (Pickr skin: `classic`/`monolith`/`nano`) and `hide_description` (hide the raw text input). Saving a color writes the HEXA string (e.g. `#3F51B5CC`) back into the field, and clearing sets the literal `none`. Five formatters share the same field type: `color_pickr_default` prints the stored string, while `color_pickr_square`, `color_pickr_circle`, `color_pickr_hexagon` and `color_pickr_line` render a shaped `<div>` whose `background-color` is the stored value (via matching Twig templates and `hook_theme` entries). There is no admin/global settings page (`configure` is null), no permissions, no config schema, and no dependencies beyond core. `hook_help` renders the README (using the Markdown filter module if present). Everything is chosen per field on the *Manage form display* / *Manage display* tabs, so a site builder adds a Color pickr field to any fieldable entity and picks the widget theme and a display shape.

---

- Add a single-color field (`color_pickr_code`) to a content type, taxonomy term, or any fieldable entity.
- Let editors pick a color from a graphical swatch/hue picker instead of typing a hex code.
- Store colors as HEXA (with alpha), e.g. `#3F51B5CC`, from the Pickr save action.
- Switch the picker skin per field between Classic, Monolith, and Nano themes.
- Hide the raw text input on the edit form so only the swatch is shown (`hide_description`).
- Display a saved color as a small square swatch with the `color_pickr_square` formatter.
- Display a saved color as a circular swatch with the `color_pickr_circle` formatter.
- Display a saved color as a hexagon swatch with the `color_pickr_hexagon` formatter.
- Display a saved color as a horizontal line/bar with the `color_pickr_line` formatter.
- Display the raw color string as text with the `color_pickr_default` formatter.
- Capture a brand/theme accent color on a "Settings" content type for use in templates.
- Let content authors tag events, categories, or labels with a chosen color.
- Provide per-node background or highlight colors driven by an editor-selected value.
- Offer a color swatch on a product/variation entity for a simple color attribute.
- Use rgba/hsla/cmyk output modes exposed by the Pickr interaction panel.
- Present predefined brand swatches (the widget ships a fixed swatch palette) for quick selection.
- Skip empty values automatically — the formatter renders nothing when the value is empty or `none`.
- Reuse the `color_pickr_*` theme hooks to override how each shape swatch is rendered in a custom theme.
- Build a color legend/list by combining a multi-value Color pickr field with a shape formatter.
- Attach the `color_pickr/color_pickr` library only where the widget is used (via the field element `#attached`).
- Provide a lightweight color field without depending on jQuery UI or a full theming module.
