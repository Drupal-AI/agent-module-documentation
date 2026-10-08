<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Multiselect Dropdown provides a `multiselect_dropdown` form render element that shows a set of checkboxes inside a native `<dialog>` opened from a select-like toggle button, plus a matching field widget for multi-value option fields.

---

The core deliverable is a `FormElement` (`#type => 'multiselect_dropdown'`, class
`Drupal\multiselect_dropdown\Element\MultiselectDropdown`) that extends core `Checkboxes`:
it renders the options as checkboxes with `role="option"` inside a themeable dialog, driven
by `data-multiselect-dropdown-*` attributes and the `multiselect_dropdown/element` library
(vanilla JS, `core/once`, no jQuery). It supports configurable toggle labels for
none/single/plural/all selections (with a `%d` count placeholder), an accessible aria
label, optional select-all / select-none / submit / clear buttons, an optional live search
field with a character threshold, a modal breakpoint (below which the dialog is modal), a
default-open flag, and nested/hierarchical options via a `data-multiselect-dropdown-depth`
attribute. A field widget (`multiselect_dropdown`, extends `OptionsWidgetBase`) exposes the
element for `entity_reference`, `list_integer`, `list_float`, and `list_string` fields whose
cardinality is not 1, configured on *Manage form display* with the label/search settings
(schema `field.widget.settings.multiselect_dropdown`). There is no global config page, no
permissions, and no Drush. Two submodules extend it: `multiselect_dropdown_bef` adds a
Better Exposed Filters widget so it can be a Views exposed filter, and
`multiselect_dropdown_polyfill` loads the GoogleChrome dialog-polyfill for older browsers.
Templates are fully overridable as long as the required data attributes remain.

---

- Replace a tall list of checkboxes on a form with a compact select-like dropdown.
- Add a multi-select widget to an entity-reference field with cardinality > 1.
- Use it as the form widget for a `list_string`/`list_integer`/`list_float` multi-value field.
- Give editors a searchable dropdown when a field has many allowed options.
- Show a running count ("3 Items Selected") on the toggle button.
- Offer "Select all" / "Select none" buttons inside the dropdown.
- Provide a live search box to filter long option lists, only filtering after N characters.
- Present hierarchical taxonomy terms with indentation inside the dropdown.
- Turn a Views exposed taxonomy/list filter into a multiselect dropdown (via the BEF submodule).
- Let site visitors filter a view by multiple values from one compact control.
- Keep the filter dialog open across AJAX exposed-filter submissions (BEF "persist open").
- Make the dropdown modal on small screens but inline on desktop (modal breakpoint).
- Use the render element directly in a custom form via `'#type' => 'multiselect_dropdown'`.
- Localize/customize all button and status labels per widget instance.
- Provide an accessible (WCAG 2.2 AA-oriented) multi-select with screen-reader instructions.
- Support browsers back to ~2019 by enabling the dialog polyfill submodule.
- Theme the dropdown to match a design system by overriding the template.
- Add a clear button that resets and resubmits the selection.
- Set a custom accessible aria-label on the toggle button.
- Default the dropdown to open on page load for a prominent filter.
- Avoid jQuery UI multiselect widgets in favor of a lightweight native-dialog solution.
- Give a per-name template suggestion (`multiselect_dropdown__<name>`) for targeted theming.
- Constrain the search input's label display (before/after/invisible/attribute).
