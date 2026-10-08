JSON-RPC 2.0 Core ships a set of ready-made JSON-RPC method plugins for common Drupal core administrative operations (cache rebuild, maintenance mode, route rebuild, listing permissions/plugins, granting a permission to a role).

---

This submodule of the JSON-RPC project provides concrete `JsonRpcMethod` plugins in `Plugin/jsonrpc/Method/` that expose selected core operations over the `/jsonrpc` endpoint. Every one declares an `access` array of admin permissions (`administer site configuration` or `administer permissions`), so they are only callable by suitably privileged, authenticated API clients. `cache.rebuild` flushes all caches; `route_builder.rebuild` rebuilds the router; `maintenance_mode.isEnabled` reads/sets `system.maintenance_mode` state from a boolean param; `user_permissions.list` pages the site's permissions; `user_permissions.add_permission_to_role` grants a permission to a role loaded by UUID (via `EntityParameterFactory`), validating the role entity before save; and `plugins.list` returns the definitions of any plugin manager service named in a `service` param. They serve as both useful automation endpoints and reference implementations for writing your own method plugins. Depends on `jsonrpc`.

---

- Rebuild all Drupal caches remotely via `cache.rebuild`.
- Rebuild the router remotely via `route_builder.rebuild`.
- Enable or disable maintenance mode over RPC (`maintenance_mode.isEnabled`, boolean `enabled` param).
- List all site permissions with pagination (`user_permissions.list`).
- Grant a permission to a role identified by UUID (`user_permissions.add_permission_to_role`).
- List the plugin definitions of any plugin manager service (`plugins.list`, `service` param).
- Drive routine site administration from a decoupled admin client.
- Automate cache clears after a deployment through an API call.
- Toggle maintenance mode from CI/CD without shell access.
- Introspect available permissions when building an admin UI.
- Programmatically assign permissions during automated provisioning.
- Enumerate plugins of a given type for tooling/documentation.
- Use the classes as templates for custom `JsonRpcMethod` plugins.
- Restrict these operations to admin-permissioned API tokens only.
- Page large permission lists with `limit`/`offset`.
- Load role parameters safely by UUID via the entity parameter factory.
- Batch several core operations in one JSON-RPC request.
- Validate role changes (constraint violations become invalid-params errors).
