# Field Group bootstrap — agent index

Bootstrap 5 field-group formatters for the `field_group` module. No settings page
(`configure` null), no permissions, no config schema, no Drush. Requires `field_group` and a
Bootstrap 5 theme.

- **Every formatter, its id, contexts, settings, and the Twig-element caution** →
  [plugins/formatters.md](plugins/formatters.md)

Key facts:
- Plugins in `src/Plugin/field_group/FieldGroupFormatter/` (`@FieldGroupFormatter`), most support
  `form` + `view` contexts. Render elements in `src/Element/`; JS/CSS in
  `field_group_bootstrap.libraries.yml`.
- Choose a formatter per field group on *Manage form display* / *Manage display* (Field Group UI).
