# Views Fields On/Off — agent index

A Views **field** and **filter** (both plugin id `views_fields_on_off_form`) that let visitors show/
hide chosen View fields via the exposed form. No global config (`configure` null), no permission, no
Drush. Config schema for both handlers. Requires core Views.

- **Add & configure the On/Off field or filter in a View: options, widget types, defaults, bypass
  option, and the pre_view exclusion mechanics** → [configure/views.md](configure/views.md)

Key facts:
- Field handler: `Plugin/views/field/ViewsFieldsOnOffForm` (`@ViewsField`), always exposed.
- Filter handler: `Plugin/views/filter/ViewsFieldsOnOffForm` (`@ViewsFilter`, extends `InOperator`);
  must tick "Expose this filter" to appear.
- Both `query()` are empty — no query change; `hook_views_pre_view()` sets `exclude = 1` on the
  fields the visitor did **not** select. Only hides already-configured fields (no data disclosure).
- Widget choice: `checkboxes` | `radios` | `select` | `multi_select`. Selection read from POST then
  GET (`_views_fields_on_off_get_selected`).
