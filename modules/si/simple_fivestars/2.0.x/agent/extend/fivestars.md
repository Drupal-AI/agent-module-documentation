<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the Fivestars element, widget & formatter

## Field usage
For any `integer`, `decimal`, or `float` field:
- **Manage form display:** set the widget to **Fivestars** (`FivestarsWidget`). Setting `hide_label` renders the widget with `#title_display = invisible`.
- **Manage display:** set the formatter to **Fivestars** (`FivestarsFormatter`), which themes each value with `#theme => 'fivestars'`.

## The form element
`@FormElement('fivestars')` (`FivestarsElement`):
- `#input = TRUE`, `#pattern = '[0-5]'`, wrapped in `form_element`.
- `processFivestars()` builds radios 0–5 (`<input type="radio" name=... value=0..5>` + `<label>`), marks the `#default_value` checked, and attaches `simple_fivestars/main`.
- Use directly in a custom form: `$form['rating'] = ['#type' => 'fivestars', '#default_value' => 3];`

## Display rendering
`simple_fivestars_preprocess_fivestars()` sets `width = number * 2 * 10` (percent) and attaches the library; `fivestars.html.twig` overlays a `.fivestars__value` bar of that width on the star background. Decimal values therefore render as a proportional fill.

## Notes
- The submitted value is an ordinary Form-API field value (CSRF-protected, access-gated). There is no standalone rating/AJAX endpoint in this version (the code notes `@TODO Add support #ajax`).
