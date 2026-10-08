<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IMS Options Widget — agent index

One field **widget**, **"IMS select list"** (id `ims_options_select`), extending core
`OptionsSelectWidget`. It moves already-selected options to the **top** of the option list so
selection order is preserved (useful with the parent module's `orderable` re-ordering). **No
settings, no configure route, no config schema, no permissions, no Drush, no plugin types.**
Its only persistent state is the widget `type` on a field component in an `entity_form_display`.

- **Selecting the widget, applicable field types, where it's stored, the no-optgroups caveat** →
  [configure/widget.md](configure/widget.md)

Key facts: widget id `ims_options_select`; field types `entity_reference`, `list_integer`,
`list_float`, `list_string`; `multiple_values = TRUE`; does **not** support optgroups (flattens);
depends on core `options` + parent `improved_multi_select`.
