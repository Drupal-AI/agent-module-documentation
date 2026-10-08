# Pretty Checkbox Radio (pcr) — agent index

Restyles checkbox/radio inputs into button-friendly "pretty" elements via a field widget
and two Better Exposed Filters (BEF) widgets. No config UI (`configure` null), no
permissions, no config schema, no Drush. Depends on core `options` + `better_exposed_filters`.

- **How to apply it (field widget `options_pretty`, BEF widgets `pretty_bef` /
  `pretty_single_bef`), the `#pretty_option` flag, theme hooks and CSS library** →
  [configure/usage.md](configure/usage.md)

Key facts:
- Mechanism: `hook_element_info_alter` adds `PrettyElement::process` to `checkbox`, `radio`,
  `checkboxes`, `radios`; any element with `#pretty_option = TRUE` is rewritten
  (`#theme = elements__pretty_options`, `#title_display = hidden`, attaches `pcr/pretty_elements`).
- Field widget `options_pretty` (`PrettyOptionsWidget` extends core `OptionsButtonsWidget`);
  field types: `boolean`, `list_string`, `list_integer`, `list_float`, `entity_reference`.
- BEF widgets: `pretty_bef` (radios/checkboxes), `pretty_single_bef` (single on/off).
- Purely presentational; stores nothing, gates nothing. No security surface.
