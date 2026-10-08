<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Select A11y NG turns Drupal `<select>` elements into an accessible, searchable single/multiple-select widget by wrapping the Pidila `select-a11y` JavaScript library (the `bordeaux-metropole/select-a11y` fork, installed to `/libraries/select-a11y`).

---

The core module ships a `@FormElement("select_a11y_ng")` render element (extending core `Select`) and a `@FieldWidget` (`SelectA11yNGWidget`, extending `OptionsSelectWidget`) for `list_integer`, `list_float`, `list_string`, and `entity_reference` fields. Its pre-render steps build a JSON config (`multiple`, `placeholder`, text direction, current language) into a `data-select-a11y-ng-config` attribute and attach the `select_a11y_ng.widget` library; the widget JS reads that attribute and instantiates the accessible select. You enable it per field on **Manage form display** by choosing the "Select A11y NG" widget and its `placeholder`/`search` settings — there is no global configuration route, no permissions, and no controllers. Three optional submodules extend the same widget to other subsystems: `select_a11y_ng_bef` (Better Exposed Filters filter + sort widgets), `select_a11y_ng_facets` (a facets dropdown widget that navigates to the selected option's facet URL), and `select_a11y_ng_webform` (a checkbox on standard Webform select elements that swaps them to the accessible widget, stripping select2/chosen/choices).

Because the module is a pure form-element/widget with output-only, Twig-auto-escaped rendering and JSON-encoded config, it has no access-control, SQL, HTTP, deserialization, or command-execution surface. Setup is: install the JS library via Composer, enable the module (and any needed submodule), then select the widget where you want an accessible list.
---
- Replace a plain select field with an accessible, keyboard-navigable widget.
- Add type-ahead search to a long options list.
- Provide an accessible multiple-select for an entity_reference field.
- Use accessible selects for `list_string`/`list_integer`/`list_float` fields.
- Set a custom placeholder ("Search in list") on the widget.
- Toggle the in-widget search box on or off per field.
- Localize the widget UI to the current content language.
- Apply the widget to a Better Exposed Filters exposed filter (bef submodule).
- Use the accessible widget for a BEF exposed sort.
- Render a facet as an accessible dropdown (facets submodule).
- Navigate to a facet result by selecting an option in the facet widget.
- Swap a Webform select element to the accessible widget (webform submodule).
- Disable select2/chosen/choices on a Webform element in favor of a11y select.
- Improve WCAG conformance of select-heavy forms.
- Configure the widget entirely from Manage form display (no global settings).
- Override widget config per element via `#select_a11y_ng`.
- Provide a screen-reader-friendly multiselect on public forms.
- Keep right-to-left language support in the widget.
- Use a single accessible select component across fields, filters, facets, and webforms.
- Add an accessible list picker without writing custom JS.
