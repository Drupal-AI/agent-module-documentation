# ds_extras features

Enable/disable each feature at `/admin/structure/ds/settings` (route `ds.admin_settings`,
config stored via `ds.settings` / `ds_extras` schema).

| Feature | What it does |
|---|---|
| Block region | Exposes a Display Suite layout region as a placeable block (Block layout). |
| Extra fields | Surfaces "extra fields" declared by other modules (e.g. node links, submitted-by) on DS displays. |
| Field permissions | Adds per-DS-field *view* permissions so roles can be shown/hidden individual fields. Permissions are generated dynamically per entity/field by `Drupal\ds_extras\ExtrasPermissions::extrasPermissions` (`ds_extras.permissions.yml` uses a `permission_callbacks`). |
| Hidden region | A region whose fields are still built but not rendered/printed. |
| Switch view mode field | An inline field that switches the entity from one view mode to another. |

Permissions: dynamic view permissions per field (one per entity-type/bundle/field), plus
whatever the enabled features expose. Check `/admin/people/permissions` after enabling.
