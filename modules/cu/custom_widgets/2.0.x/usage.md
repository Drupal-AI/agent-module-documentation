<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom widgets provides two field widgets: an autocomplete widget for List (float/integer/string) fields that suggests from the field's allowed values, and a "flat select" widget that flattens a taxonomy term hierarchy into a single select.
---
The **Autocomplete** widget (`custom_widgets_text_autocomplete`) replaces the default options select/checkboxes on `list_float`, `list_integer`, and `list_string` fields with a text autocomplete that queries the field's own allowed-values list (from the UI or a `callback_allowed_values_function`). It can optionally render through the Select2 module when that is installed. Suggestions are served by a JSON controller; each request carries an HMAC (`Crypt::hmacBase64(serialize($params), Settings::getHashSalt())`) computed from the field name, entity type, item count, matching method, and uid at render time, and the controller recomputes and compares that hash before returning results — a request with a mismatched hash gets `AccessDeniedHttpException`.

The **Flat select** widget (`custom_widgets_flat_select`, extends core `OptionsSelectWidget`) targets entity-reference-to-taxonomy fields: it relabels each option as its full parent chain (`Parent >> Child`) and can force selection of the deepest (leaf) level by hiding top-level terms. The autocomplete routes are declared `_access: 'TRUE'`, so their only gate is the HMAC hash keyed on the site hash salt; the controller only reads a field's *allowed-values definition* (config-level option labels/keys) and returns them as JSON — it performs no writes and does not reflect the user's `q` query into HTML.
---
- Turn a long List (string) field into a typeahead instead of a giant select.
- Autocomplete over List (integer) / List (float) allowed values.
- Suggest values defined via a `callback_allowed_values_function`.
- Limit the number of autocomplete suggestions returned (max_items).
- Choose "contains" vs "begins with" matching for suggestions.
- Render the autocomplete through Select2 when that module is enabled.
- Flatten a taxonomy hierarchy into one select with `Parent >> Child` labels.
- Force editors to pick a leaf (deepest) taxonomy term.
- Apply the flat-select widget to entity_reference taxonomy fields on any bundle.
- Configure widgets per form display on the Manage form display page.
- Keep option keys hidden from users while showing readable labels.
- Speed up data entry on content types with large controlled vocabularies.
- Reuse the same allowed-values list for both editing and validation.
- Validate submitted values against the field's allowed options on save.
- Serve suggestions as JSON from the custom_widgets autocomplete route.
- Gate autocomplete requests with an HMAC derived from the site hash salt.
- Swap between plain textfield tags style and Select2 multi-select.
- Support multi-value list fields with comma/tag entry.