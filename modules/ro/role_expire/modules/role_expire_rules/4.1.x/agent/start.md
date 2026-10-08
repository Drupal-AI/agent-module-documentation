# Role Expire Rules — agent index

Glue submodule: exposes Role Expire to the **Rules** module. Requires `role_expire` + `rules`.
No config, permissions, forms or Drush of its own.

- **The two Rules actions and the Rules event it adds (ids, context, how they map to the API)** →
  [api/rules-integration.md](api/rules-integration.md)

Key facts:
- Actions: `role_expire_set_expire_time` (context: `user`, `roles` [multiple], `date`) and
  `role_expire_remove_expire_time` (context: `user`, `roles`). Both category "User".
- Event: `role_expire_event_role_expires` ("When a role expires"), context `account` +
  `ridBefore`; backed by `RoleExpiresEvent` in the parent module.
- Actions delegate to the parent `role_expire.api` service (`writeRecord()` / `deleteRecord()`).
- Used inside `rules_reaction_rule` config entities (`rules.reaction.<id>`), e.g. built with the
  `plugin.manager.rules_expression` service.
