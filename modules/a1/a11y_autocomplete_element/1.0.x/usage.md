<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Accessible Autocomplete Element/Widget provides a WAI-ARIA combobox render element and field widget that turns any core `select` into a keyboard- and screen-reader-friendly type-to-filter autocomplete.

---

The module adds a Form API render element (`#type => a11y_autocomplete`) that extends core's `Select`
element, plus a matching field widget (`A11yAutocompleteWidget`) that extends `OptionsSelectWidget`.
It renders a normal `<select>` server-side (so all option values, allowed values and entity-reference
access filtering come from core), then a small client-side JavaScript library (`@drupal/autocomplete`)
progressively enhances that hidden select into an accessible combobox: users type to filter options,
navigate with the keyboard, and multi-value fields show removable "pill" tokens. Because the enhancement
is entirely client-side over options the server already rendered, no new routes, controllers, AJAX
endpoints, permissions or config forms are introduced. It depends only on core Options and expects the
JS library to be installed via npm (`@drupal/autocomplete`), asset-packagist, or a manual download to
`libraries/a11y_autocomplete`.

---

- Replace a long core `select` dropdown with a type-to-filter autocomplete.
- Add an accessible (WAI-ARIA combobox) select replacement for screen-reader users.
- Use `#type => 'a11y_autocomplete'` in a custom Form API form anywhere you'd use `#type => 'select'`.
- Set "Accessible autocomplete" as the widget on an entity-reference field via Manage form display.
- Set it as the widget on a `list_string`, `list_integer` or `list_float` (allowed-values) field.
- Provide keyboard navigation over option lists.
- Give multi-value selects removable pill tokens for chosen items.
- Improve typeahead UX on taxonomy term reference fields.
- Improve usability of country/state or other long option lists.
- Keep stored values identical to a normal select (the module only changes the UI).
- Preserve a field's `#required` behaviour, including for multi-value fields.
- Enhance node/edit forms with accessible autocompletes without custom JS.
- Offer an accessible alternative to core's `entity_autocomplete` for options-backed fields.
- Progressively enhance forms (falls back to a plain select if JS is unavailable).
- Serve the JS library from inside the Drupal root (auto-copied) for AdvAgg / no-aggregation setups.
- Integrate the `@drupal/autocomplete` library with Drupal's asset pipeline.
- Support installation via npm, asset-packagist (`libraries/drupal--autocomplete`), or manual clone.
- Use with the `foxy` module to manage the JS dependency instead of a manual library install.
- Report a clear admin status-report error when the autocomplete JS library cannot be found.
- Build accessible faceted or tag-style multi-select inputs.
- Reduce mouse dependence when selecting from large dropdowns.
