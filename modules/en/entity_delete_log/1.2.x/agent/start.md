# Entity Delete Log — agent index

Logs a DB row whenever an entity of a **selected type** is deleted (who/when/what). No plugins,
no Drush, no permissions of its own, no config schema. State lives in one simple config value and
one base table.

Core facts:
- Enable logging per entity type on `/admin/config/content/entity-delete-log`
  (route `entity_delete_log.settings`, permission **administer site configuration**).
- Selection is stored in config `entity_delete_log.settings` → key `entity_types`
  (array of entity-type ids, e.g. `['node','user']`; empty/absent = log nothing).
- Rows are written to the base table **`entity_delete_log`** by `hook_entity_delete()`.
- View them at `/admin/reports/entity-delete-log` (Views view `entity_delete_log`,
  permission **access site reports**).

Docs:
- **Configure which types are logged, table schema, the report view** →
  [configure/logging.md](configure/logging.md)
- **The two alter hooks a module can implement** → [hooks/alter-hooks.md](hooks/alter-hooks.md)
