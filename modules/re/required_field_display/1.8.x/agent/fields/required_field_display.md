<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Required Field Display marks required fields

The module is entirely `required_field_display.module` (~100 lines, no `src/`). It decorates two
Field UI admin screens with a marker and attaches a stylesheet; it never touches field data or
validation.

## Manage fields screen — `hook_preprocess_table()`

`required_field_display_preprocess_table()` runs on every rendered table and acts only when the
table id is `field-overview` (the Field UI "Manage fields" listing). For that table it:

1. Adds the wrapper class `field-display-overview` and attaches the library
   `required_field_display/ui_styles`.
2. Iterates `$table['rows']`, splitting each row id `"{entity_type}.{bundle}.{field}"` on `.` to get
   the field name, and loads the bundle's field definitions once via
   `entity_field.manager`→`getFieldDefinitions($type, $bundle)`.
3. For each field, if `$definition->isRequired()` it calls
   `->cells['label']['attributes']->addClass('required-field')`.
4. If the field is required **and** its storage cardinality is `-1` (unlimited), it instead adds
   `required-field-multivalue`.

## Manage form display screen — `hook_form_FORM_ID_alter()`

`required_field_display_form_entity_form_display_edit_form_alter()` targets the
`entity_form_display_edit_form` (the "Manage form display" screen). It adds the wrapper class and
library, then for each row in `$form['fields']` (skipping `#`-prefixed render keys) looks up the
field definition and:

- if required, sets `$form['fields'][$field]['human_name']['#suffix'] =
  '<span class="required-field"></span>';`
- if required and unlimited cardinality, sets the suffix to
  `'<span class="required-field-multivalue"></span>'`.

## What counts as "required"

Both hooks share the same test:

- `$field_definition->isRequired()` — the standard required flag.
- **`require_on_publish` integration** — if that contrib module is enabled and the definition
  implements `ThirdPartySettingsInterface` and carries the third-party setting
  `require_on_publish.require_on_publish`, the field is also marked. (This is the only optional
  integration; `require_on_publish` is not a hard dependency.)

## The marker (CSS) and how to restyle it

`css/required_field_display_ui.css` renders the marker with `::after` inside
`.field-display-overview`:

| Class | Rendered content | Meaning |
| --- | --- | --- |
| `required-field` | ` *` (red `#e32700`) | required field |
| `required-field-multivalue` | ` * ∞` (red) | required *and* unlimited cardinality |

The markup the module injects is a static empty `<span>` — the visible glyph comes entirely from the
stylesheet. To change the symbol, color, or add a tooltip, override the two rules in your theme
(target `.field-display-overview .required-field::after` /
`.field-display-overview .required-field-multivalue::after`), or unset/replace the
`required_field_display/ui_styles` library with your own via `hook_library_info_alter()`.

There is nothing to configure — no settings form, no permissions, no config entity. Enabling the
module is the entire setup; the markers appear on the two screens above for any user who can already
reach Field UI.
