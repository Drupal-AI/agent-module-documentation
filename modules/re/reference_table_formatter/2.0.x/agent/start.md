# Reference Table Formatter — agent index

One field formatter, **"Table of Fields"** (`entity_reference_table`), that renders the fields of
referenced entities as an HTML table (one entity per row, one field per column). Applies to
`entity_reference` and `entity_reference_revisions` fields. No config page (`configure` null), no
permissions, no Drush. Core-only (needs Field UI to select it). Config schema for the formatter
settings.

- **Selecting & configuring the formatter (settings, supported field types, limitations)** →
  [configure/formatter.md](configure/formatter.md)
- **Reusing the `EntityToTableRenderer` service in custom code** → [api/renderer.md](api/renderer.md)

Key facts:
- Plugin: `src/Plugin/Field/FieldFormatter/EntityReference.php` (`id = entity_reference_table`, field
  types `entity_reference`, `entity_reference_revisions`). `FieldCollection.php` exists but is not
  UI-selectable (deprecated).
- Settings (`field.formatter.settings.entity_reference_table`): `view_mode`, `show_entity_label`,
  `hide_header`, `empty_cell_value`. Defaults: view_mode `default`, both bools `0`, empty string.
- Service `reference_table_formatter.renderer` = `EntityToTableRenderer` (`getTable()` builds a
  `#theme => 'table'` array).
- **Constraints:** requires the **Default** reference selection handler and a **single** target
  bundle; other handlers / empty `target_bundles` throw exceptions. Rows are filtered by `view` access.
