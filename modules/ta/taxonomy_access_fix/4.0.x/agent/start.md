# Taxonomy Access Fix — agent index

Adds fine-grained per-vocabulary and "any vocabulary" permissions to Drupal Core's
Taxonomy module by replacing its term/vocabulary access handlers and term
entity-reference selection plugin. No configuration: enable/disable toggles the
behavior. `administer taxonomy` bypasses every check. Depends only on core `taxonomy`.

- **Permissions** (the full permission list and exactly what each gates) →
  [permissions/taxonomy_access_fix.md](permissions/taxonomy_access_fix.md)
- **Mechanics / extension points** (which handlers & plugin it replaces, overview-page
  access logic, reset-form route/redirect, D7 migration, LogicException guards) →
  [extend/mechanics.md](extend/mechanics.md)

No config UI (`configure` route: none), no config schema, no Drush commands, no plugin
types, no submodules.
