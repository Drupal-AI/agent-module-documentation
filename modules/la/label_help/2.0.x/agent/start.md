# Label Help — agent index

Adds help text **below a field's label** on entity forms. No admin settings page (`configure: null`).
Two ways to set it: per-field UI (stored as a third-party setting) or the `#label_help` FAPI property
in code. No routes, no permissions, no Drush.

- **Where the text is stored + the field settings form + debug flags + templates** →
  [configure/label-help.md](configure/label-help.md)
- **Setting help text from code with `#label_help`** → [api/label-help-property.md](api/label-help-property.md)

Key facts:
- UI value is stored on the `field_config` entity at
  `third_party_settings.label_help.label_help_description` (e.g. in
  `field.field.node.article.<field>`), written/cleared by the field edit form's "Label help message"
  textarea.
- Rendering is done by a process callback (`label_help_process_form`) with ~18 per-widget "use cases"
  choosing `#label_suffix` / `#field_prefix` / `#description` / `#title`.
- Submodule: `label_help_test` (demo content type) — see
  `modules/label_help_test/2.0.x/`.
