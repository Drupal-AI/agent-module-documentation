# Label Help Test — agent index

Hidden **test/demo** submodule of Label Help. Enabling it installs the
`test_label_help_core_fields` content type with one field of nearly every core type (all named
`field_lh_*`), each pre-set with Label Help text, to exercise the parent module's per-widget placement.
Depends on `label_help`. No config/routes/permissions/services/plugins of its own.

- **Parent module (how Label Help actually works)** → `../../../2.0.x/agent/start.md`

Key facts:
- Ships (`config/install`) the node type `test_label_help_core_fields` + ~24 `field_lh_*` fields, each
  with `third_party_settings.label_help.label_help_description`, plus default form/view displays.
- `label_help_test.module` adds `#label_help` to the Article and test-type node title, and defines two
  ad-hoc `#label_help` form elements (`field_lh_textfield`, `field_lh_checkbox`).
- `hidden: TRUE`, `package: Testing` — a fixture, not for production use.
