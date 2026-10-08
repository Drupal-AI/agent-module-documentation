Label Help Test is a hidden test/demo submodule of Label Help that installs a `test_label_help_core_fields` content type covering ~24 core field types, each pre-configured with Label Help text, so you can see and test the module's placement across every widget.

---

Enabling `label_help_test` imports (via `config/install`) a node type `test_label_help_core_fields`
("TEST Label Help Core Fields") plus one field of nearly every core field type — boolean, string,
string_long, text, text_long, text_with_summary, integer, decimal, float, list_(string|integer|float),
email, link (with and without title), datetime, date, timestamp, file, image, and entity references to
node/term/user/other — all named `field_lh_*`. Each field's config carries a
`third_party_settings.label_help.label_help_description` value, and the module's `.module` also uses the
`#label_help` Form API property to add help to the node title on Article and on the test type's form,
plus two ad-hoc `#label_help` form elements (a textfield and a checkbox). It ships default form and view
displays. The module is marked `hidden: TRUE` (a Testing-package fixture) and depends on `label_help`. It
provides no configuration, routes, permissions, services or plugins of its own — it exists purely to
exercise and demonstrate the parent module's per-widget placement logic.

---

- Visually verify Label Help placement across every core field widget on one page.
- Provide a ready-made fixture content type for manual QA of the Label Help module.
- Check how help text renders on boolean/checkbox widgets.
- Check placement on select/list widgets (list_string, list_integer, list_float).
- Check placement on datetime and date widgets.
- Check placement on link fields with and without allowed link text.
- Check placement on file and image upload widgets.
- Check placement on entity-reference autocomplete widgets (node/term/user references).
- Confirm the `#label_help` code path works on the node title field.
- Demonstrate two custom `#label_help` form elements (textfield + checkbox) added in code.
- Serve as regression coverage when changing Label Help's widget "use case" cascade.
- Give developers example field config showing the `label_help.label_help_description` third-party setting.
- Reproduce a placement bug on a specific field type quickly.
- Compare help-text styling across Seven/Claro/Gin themes on many widgets at once.
- Onboard a contributor to the module by showing all placements working.
- Provide sample data for automated functional tests of Label Help.
- Test text_long and text_with_summary (body-style) widget placement.
- Test numeric field (integer/decimal/float) placement.
- Test email field placement.
- Confirm help text survives config export/import as third-party settings.
