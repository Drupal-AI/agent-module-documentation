<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Multiselect Dropdown — agent index

A `multiselect_dropdown` form render element (checkboxes in a native `<dialog>`) plus a
field widget for multi-value option fields. No global config page (`configure` null), no
permissions, no Drush. Config schema covers the field-widget settings. Vanilla JS +
`core/once` (no jQuery).

- **The render element `#type => 'multiselect_dropdown'` and all its `#…` properties for
  custom forms** → [api/element.md](api/element.md)
- **The field widget: which field types, cardinality rule, settings** →
  [configure/field-widget.md](configure/field-widget.md)
- **Theming: template, required `data-multiselect-dropdown-*` attributes, theme
  suggestions, libraries** → [theming/template.md](theming/template.md)

Submodules (own docs):
- `multiselect_dropdown_bef` (Views exposed filter via Better Exposed Filters) →
  [../../modules/multiselect_dropdown_bef/1.2.x/agent/start.md](../../modules/multiselect_dropdown_bef/1.2.x/agent/start.md)
- `multiselect_dropdown_polyfill` (dialog polyfill for old browsers) →
  [../../modules/multiselect_dropdown_polyfill/1.2.x/agent/start.md](../../modules/multiselect_dropdown_polyfill/1.2.x/agent/start.md)

Key facts:
- Element class `Drupal\multiselect_dropdown\Element\MultiselectDropdown` extends core
  `Checkboxes`; theme hook `multiselect_dropdown`; library `multiselect_dropdown/element`.
- Widget `multiselect_dropdown` (`OptionsWidgetBase`) applies to `entity_reference`,
  `list_integer`, `list_float`, `list_string` with cardinality **≠ 1**.
- Nesting: options carry `data-multiselect-dropdown-depth` (or a `-`-prefixed title, as
  from views taxonomy) to indicate hierarchy.
