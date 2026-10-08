# Permissions

The module gates *who may run a sync* on two kinds of permission. Configuring the module is a separate,
core permission.

| Permission | Source | Grants |
|---|---|---|
| `administer site configuration` | core (route requirement) | Access the settings form `/admin/config/regional/entity-translation-sync`. Not module-defined. |
| `synchronize any entity translation` | `entity_translation_sync.permissions.yml` (static) | Run a sync on **any** enabled entity type. |
| `synchronize <entity_type_id> translation` | **generated** by `EntityTranslationSyncPermissions::permissions` | Run a sync on that one entity type only (e.g. `synchronize node translation`, `synchronize media translation`). |

## Generated per-entity-type permissions

`entity_translation_sync.permissions.yml` declares a `permission_callbacks:` entry pointing at
`Drupal\entity_translation_sync\EntityTranslationSyncPermissions::permissions`. That method iterates the
entity type ids present in `entity_translation_sync.settings:entity_types` and emits one permission per
type:

- name: `synchronize <entity_type_id> translation`
- title: `Synchronize <Entity type label> translation`

So the list of available per-type permissions **changes with configuration** and does not exist in the
YAML — you will only see e.g. `synchronize node translation` after `node` is enabled (and caches are
cleared). Grepping the `.permissions.yml` alone misses them.

## Where the permissions are enforced

- **Reaching the sync page**: `EntityTranslationSyncAccessChecker::access()` requires
  `synchronize any entity translation` **OR** `synchronize <type> translation` (checked with
  `AccessResult::allowedIfHasPermissions(..., 'OR')`), *plus* the route's own `_entity_access: <type>.view`.
- **Showing the operation link**: `hook_entity_operation` uses the same OR check before adding the
  "Entity translation sync" operation to entity listings.

None of these permissions are marked `restrict access: TRUE`.
