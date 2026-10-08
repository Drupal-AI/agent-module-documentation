# Taxonomy Container — agent index

Adds an entity-reference **selection handler** that renders a taxonomy term reference field as a
grouped `<select>`: root terms become `<optgroup>` headings, children become indented options.
Depends on core `taxonomy`. No config page (`configure` null), no permissions, no Drush. One config
schema key (`prefix`).

- **Enable the handler on a field, the `prefix` setting, and how grouping/access works** →
  [configure/selection.md](configure/selection.md)

Key facts:
- Plugin: `TermSelection`, id `taxonomy_container`, group `taxonomy_container`, extends core
  `Drupal\taxonomy\Plugin\EntityReferenceSelection\TermSelection`.
- Selected per field via **Reference method** = "Taxonomy term selection (with groups)".
- Stored in the field's `handler` / `handler_settings` (schema
  `entity_reference_selection.taxonomy_container`, adds `prefix`, default `-`).
- Only the first hierarchy level becomes optgroups; term labels are `Html::escape()`d and
  `access('view')`-checked; core auto-create options are force-hidden.
