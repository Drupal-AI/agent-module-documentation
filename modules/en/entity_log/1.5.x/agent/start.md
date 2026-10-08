# Entity Log — agent index

Logs changes to selected fields on selected entity types/bundles, to the Drupal logger and/or as `entity_log`
content entities. Depends on `dynamic_entity_reference`. No plugin types, no Drush, no config schema file.

- **Config form, what's stored in `entity_log.configuration`, the two log targets, row-limit pruning** →
  [configure/settings.md](configure/settings.md)
- **`entity_log` service (`EntityLogService`), how change diffing works, the `entity_log` entity fields** →
  [api/service.md](api/service.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config form `EntityLogConfigForm` at `admin/config/entity-log` (route `entity_log.configuration`,
  perm `administer entity log entities` — `restrict access: true`).
- Trigger: `hook_entity_update()` → `EntityLogService::logFields()`; compares `$entity->original` field values.
- Two toggles: `log_in_logger` and `log_in_entity`; `row_limit` prunes the `entity_log` table on cron.
- `entity_log` is a fieldable content entity (collection at `/admin/structure/entity_log`), captures
  old_value/new_value, log_type (entity type), the source entity (dynamic ref), acting uid and hostname.
