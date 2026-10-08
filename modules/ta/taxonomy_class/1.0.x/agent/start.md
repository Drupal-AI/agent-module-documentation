# Taxonomy Class — agent index

Adds a single string base field, `taxonomy_class` ("CSS class(es)"), to every taxonomy term.
Its first value is appended as a CSS class on the rendered term template wrapper, letting editors
style individual terms without touching templates. No settings page, no dependencies beyond core.

- **Dependencies:** none (core only; `^8 || ^9 || ^10 || ^11`).
- **Configure route:** none — no settings page, no config object, no config schema.
- **Provides:** one permission. No drush commands, no plugin types, no services, no routes.

Solution docs:
- **Add / set the per-term CSS class field** → [fields/taxonomy_class.md](fields/taxonomy_class.md)
- **How the class reaches the rendered term markup** → [theme/class-output.md](theme/class-output.md)
- **Who may edit term classes** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Base field: `taxonomy_class` (type `string`, label "CSS class(es)"), added to entity type
  `taxonomy_term` via `hook_entity_base_field_info` (`taxonomy_class_entity_base_field_info`).
  Form display: `string_textfield`, weight 35, display-configurable on the term form.
- Form alter: `taxonomy_class_form_taxonomy_term_form_alter` moves the field into a collapsed
  `details` group "Taxonomy Class settings" (`#group => 'advanced'`), shown only to users holding
  the permission; the alter returns early otherwise.
- Output: `taxonomy_class_preprocess_taxonomy_term` appends the field's FIRST value to
  `$variables['attributes']['class']`.
- Permission: `administer taxonomy classes`.
- Set programmatically: `$term->set('taxonomy_class', 'my-class')->save();`
