<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Double field adds a single field type, `double_field`, whose every item stores two independently-typed values — `first` and `second` — with their own storage types, widgets, validation and display settings.

---

One `double_field` item has exactly two properties, `first` and `second`, and `mainPropertyName()` returns NULL because neither is privileged. Each subfield independently picks one of ten storage types on the field-storage form — `boolean`, `string`, `text`, `integer`, `float`, `numeric`, `email`, `telephone`, `datetime_iso8601`, `uri` — which decides its database column (varchar/text/int/float/numeric/…) and its typed-data property type; those choices are locked once the field has data. Per-instance settings then add a label, a `required` toggle, `min`/`max` for numeric types, `on_label`/`off_label` for booleans, and an optional `list` mode with an `allowed_values` key/label list for the eight list-capable types. `DoubleField::getConstraints()` turns all of that into real Symfony constraints (`AllowedValues`, `Length`, `Range`, `NotBlank`, and `NotEqualTo` for booleans, registered by a `hook_validation_constraint_alter()`). The bundled `double_field` widget renders a sub-widget per subfield, chosen from the ones legal for that storage type (textfield, email, tel, url, color, number, range, checkbox, textarea, datetime, plus select/radios when `list` is on), each with its own label display, size, placeholder, rows/cols, and an overall `inline` toggle. Four formatters ship: `double_field_unformatted_list` (the default), `double_field_html_list` (`ul`/`ol`/`dl`), `double_field_details` (first value as the summary, second as the body) and `double_field_table` (with optional row-number column and per-column labels). Each formatter can hide a subfield, render `email`/`telephone`/`uri` values as links, format numbers, pick a date format, and show list keys instead of labels. Two Twig templates plus per-field theme suggestions make the markup themeable. The module needs no other modules, has no settings form or configure route, and defines no permissions, services or Drush commands; it also ships an optional Feeds target plugin.

---

- Store a **specification list** — "Weight | 4.2 kg", "Material | Anodised aluminium" — as one multi-value field.
- Model **opening hours** with a weekday text subfield and an hours text subfield, rendered as a table.
- Capture a **person and their role** on a credits field ("Jane Doe" / "Director of Photography").
- Build a lightweight **FAQ field**: question in `first`, long answer in `second` (type `text`), shown as a definition list.
- Store a **link label plus URL** using `string` + `uri` and let the formatter render the second as a real link.
- Record a **contact name and email address**, with the email displayed as a `mailto:` link.
- Record a **contact name and phone number**, rendered as a click-to-call `tel:` link.
- Hold a **rating verdict plus numeric score**, restricting the verdict to Gold/Silver/Bronze via `allowed_values`.
- Enforce a 0–10 numeric bound on the score subfield with the `min`/`max` instance settings.
- Attach a **caption and a date** to an item, using `datetime_iso8601` with a chosen core date format.
- Store a **percentage plus label** and format the number with a thousand marker and two decimals.
- Create a **boolean plus note** field ("Included? / conditions apply"), with custom On/Off labels.
- Present paired values as an **accordion** using the Details formatter with `open: false`.
- Render paired values as an **ordered list** by setting `list_type: ol` on the HTML List formatter.
- Render them as a **`<dl>` definition list** so the first value becomes the `<dt>` and the second the `<dd>`.
- Show only the second subfield in a teaser view mode by ticking `hidden` on the first.
- Expose just one subfield to Views by hiding the other in a dedicated display mode.
- Make one subfield optional while keeping the other mandatory via the per-subfield `required` flag.
- Offer editors a **select list or radio buttons** for a constrained subfield by turning on `list`.
- Use a **color picker** sub-widget for a `string` subfield holding a hex value.
- Use a **range slider** sub-widget for an integer subfield.
- Lay the two inputs out side by side on the edit form with the widget's `inline` setting.
- Give the table formatter **column headers** and a row-number column for a long repeatable field.
- Theme one specific field's output with the `double_field_item__field_name` theme suggestion.
- Import paired data from a CSV with the Feeds module, mapping to the `first` and `second` properties.
- Replace a pair of separate fields with one field to halve the number of columns on an entity form.
