# devel_entity_updates — agent start

Development-only tool that restores the removed `drush entity:updates` behavior: applies pending
entity type and field storage definition schema changes in code without hand-writing update hooks.
Depends on `devel`. Requires Drush 12/13. No config UI, no permissions. **Never enable in production**
(released schema changes must use `hook_update_N()` / `hook_post_update_NAME()`; see
drupal.org/node/3082442).

- Apply pending entity schema updates from the CLI (`entup`) → [drush/devel_entity_updates.md](drush/devel_entity_updates.md)
- Apply updates programmatically via `DevelEntityDefinitionUpdateManager` → [api/devel_entity_updates.md](api/devel_entity_updates.md)
