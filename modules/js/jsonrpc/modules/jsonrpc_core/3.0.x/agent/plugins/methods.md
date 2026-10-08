# Core JSON-RPC methods

All in `src/Plugin/jsonrpc/Method/`. Call them at `/jsonrpc` (caller needs `use jsonrpc services` PLUS the
method's own `access` permission).

| Method id | Access | Params | Effect / result |
|---|---|---|---|
| `cache.rebuild` | `administer site configuration` | — | `drupal_flush_all_caches()`; returns TRUE (no output schema / notification-style). |
| `route_builder.rebuild` | `administer site configuration` | — | `router.builder->rebuild()`; returns bool. |
| `maintenance_mode.isEnabled` | `administer site configuration` | `enabled` (boolean) | Sets `system.maintenance_mode` state to `enabled`; returns `"enabled"`/`"disabled"`. (Despite the name it is a setter.) |
| `user_permissions.list` | `administer permissions` | `page` (PaginationParameterFactory: `{limit, offset}`) | Returns a slice of `user.permissions->getPermissions()`. |
| `user_permissions.add_permission_to_role` | `administer permissions` | `permission` (string), `role` (EntityParameterFactory `{type, uuid}`) | `role->grantPermission($permission)`, validates the entity (constraint violations → invalid-params), `role->save()`; returns the save status int. |
| `plugins.list` | `administer site configuration` | `page` (Pagination), `service` (string, required) | `container->get($service)->getDefinitions()`, paged. `service` must name a plugin-manager service; unknown service → invalid-params; non-array (object) definitions → invalid-params. |

Implementation notes:
- `UserPermissionsBase` injects `user.permissions`; `MaintenanceModeEnabled` injects `state`; `RouteBuilder`
  injects `router.builder`; `Plugins` resolves the `service` param in `create()` and injects it as the plugin
  manager.
- `ListPermissions::outputSchema()` is a known stub (`['type' => 'foo']`) — informational only.
- These are the canonical examples of correctly declaring `access`, params, factories and output schema for the
  parent module's `JsonRpcMethod` plugin type.
