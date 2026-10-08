<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the radios/checkboxes taxonomy filter

No global settings — configure per filter in the Views UI.

## Use it

1. Edit a view and add (or edit) a **filter** on a taxonomy-term `entity_reference` field. Because
   `hook_field_views_data_alter()` rewrites the filter id to `taxonomy_index_tid_radios` for all such
   fields, the filter already uses this plugin.
2. In the filter's options, set the **form element** (the filter "type") to **Radios/Checkboxes**.
3. **Expose** the filter (radios/checkboxes only apply to exposed filters).
4. Optionally set the **`'All' value's label`** field (`all_label`) — the text shown for the
   no-selection option (defaults to `- Any -` / `<Any>` depending on core's
   `views.settings:ui.exposed_filter_any_label`).
5. Save. If the exposed filter allows **multiple** values it renders as `checkboxes`; otherwise as
   `radios`.

## How rendering works

- `defineOptions()` adds `all_label` (default derived from the core "any label" setting).
- `buildExtraOptionsForm()` adds the **Radios/Checkboxes** type option and the `all_label` textfield
  (visible/required only when type = `radios`).
- `valueForm()` (when exposed and type `radios`) switches `#type` to `radios`/`checkboxes`, drops
  `#multiple`/`#size`, sets `#all_label`, and re-keys the element under the exposed identifier.
- `exposedTranslate()` re-asserts the radios/checkboxes `#type` (the Views base transforms them to a
  select otherwise).
- `hook_form_views_exposed_form_alter()` sets the visible `All` option text to the configured
  `all_label`.

## Config schema

```yaml
# views.filter.taxonomy_index_tid_radios extends views.filter.taxonomy_index_tid
all_label:
  type: string   # label for the '<Any>' / no-selection option
```

Stored in the view under the filter handler's options. No permissions, no Drush, no plugin types to
implement.
