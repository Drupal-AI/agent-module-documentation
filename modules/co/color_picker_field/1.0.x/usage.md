<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Color Picker Field adds a "Color Picker" field type whose widget is a native color picker and whose formatter renders the chosen color as colored text.

---

Color Picker Field provides a small content-editing field for choosing a color, intended to set the text color that accompanies a body/text field. It registers a `color_picker` field type storing a single 7-character `#rrggbb` value, a widget built on the browser's native HTML5 `<input type="color">` picker (default `#ffffff`, labelled "Select Text color"), and a formatter that outputs the stored value as `<span style="color: …;">#rrggbb</span>` with the value HTML-escaped before rendering. The field is added and configured entirely through the standard Field UI — there is no dedicated settings page. The module also attaches a small JavaScript behavior on node pages that mirrors the picked color onto elements with a `.text-content` class and remembers the last choice in the browser's `localStorage`. It depends only on core Field and has no permissions, routes, or configuration of its own.

---

- Add a "Color Picker" field to any entity bundle through Structure → Manage fields.
- Let editors pick a color from the operating system's native color picker while editing content.
- Store the chosen color as a `#rrggbb` hex value on the entity.
- Render the stored color as a colored text swatch via the default Color Picker formatter.
- Pair a chosen text color with a body/text field on a content type.
- Rely only on core Field — no contrib modules or PHP libraries required.
- Run on Drupal 10.3+ and Drupal 11.
- Use the widget's default starting color of white (`#ffffff`) when no value is set.
- Preview the selected text color live on node pages via the bundled JavaScript behavior.
- Persist the most recent color choice in the browser using `localStorage`.
- Keep the field lightweight: a single field type, widget, and formatter with no admin configuration screen.
- Apply the color to page elements carrying the `.text-content` class on the canonical node route.
- Give site builders a ready-made color input without writing a custom field.
- Escape the stored value before it is placed into the rendered markup.
- Cap stored values at seven characters, matching a standard hex color code.
