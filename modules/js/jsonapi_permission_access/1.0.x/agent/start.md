# JSON:API Permission Access — agent index

Requires a new `access jsonapi routes` permission on **all** JSON:API routes, gating the core
API that is otherwise open to everyone. Depends on core `jsonapi`. No settings form
(`configure` null), no config schema, no Drush. **Tightens** access — it never loosens it.

- **How the gate works, the permission, and the shipped `json_api_user` role (grant/deny recipes)** →
  [configure/access.md](configure/access.md)

Key facts:
- Route subscriber `Drupal\jsonapi_permission_access\Routing\JsonApiRoutesAddPermission`
  (`alterRoutes`) sets `_permission: 'access jsonapi routes'` on every route whose defaults
  contain `_is_jsonapi`.
- Permission `access jsonapi routes` (`*.permissions.yml`) — **not** marked `restrict access`.
- Optional default role `json_api_user` (`config/optional/user.role.json_api_user.yml`) holds only
  that permission.
- The gate is layered *on top of* core entity/field access; it adds a prerequisite, it does not
  replace those checks. A role without the permission gets 403 on any JSON:API URL.
