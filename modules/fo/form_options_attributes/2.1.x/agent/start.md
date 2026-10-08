<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# form_options_attributes — agent start

Developer-only Form API helper. Adds one render-array property, `#options_attributes`, that
attaches HTML attributes to the *individual* options of `select`, `radios`, and `checkboxes`
elements. No admin UI, no config, no permissions, no Drush, no plugins, no dependencies —
just enable it and use the property in code (a custom form or `hook_form_alter`).

- **Use the `#options_attributes` property (structure, supported elements, examples)** → [api/form_options_attributes.md](api/form_options_attributes.md)
- **How it works under the hood + label/wrapper attributes + theming the select** → [extend/form_options_attributes.md](extend/form_options_attributes.md)

Facts an agent needs up front:
- Keys of `#options_attributes` must mirror the element's `#options` keys; each value is an
  attributes array formatted exactly like `#attributes`.
- Works on `#type` `select`, `radios`, `checkboxes`. `#options_wrapper_attributes` and
  `#options_label_attributes` are **radios/checkboxes only** (there is no wrapper/label per
  `<option>` in a select).
- For `<optgroup>` selects the keys nest: `#options_attributes[group_label][option_key]`.
- Nothing to configure or enable per field; enabling the module is the whole setup.
