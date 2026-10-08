JSON:API Permission Access adds a new `access jsonapi routes` permission and requires it on every JSON:API route, so JSON:API endpoints are only reachable by roles you explicitly grant it to — tightening (not loosening) the default open access.

---

Core JSON:API exposes all its routes to any client (anonymous included), relying solely on per-entity access checks to decide what data is returned. This module hardens that: a route subscriber (`JsonApiRoutesAddPermission`, an `EventSubscriber`) iterates every route and, for any route flagged `_is_jsonapi`, adds `_permission: 'access jsonapi routes'` as a route requirement. The net effect is that reaching *any* JSON:API endpoint now requires a role holding the new permission — a request from a role without it gets 403 before entity access is even consulted. The module defines a single permission (`access jsonapi routes`) in `jsonapi_permission_access.permissions.yml` and ships an optional default role `json_api_user` (`config/optional/user.role.json_api_user.yml`) that has only that permission. There is no settings form (`configure` is null), no config schema, and no Drush commands. This is a coarse on/off gate layered *on top of* core's normal entity/field access — it does not replace or relax those checks; it adds a prerequisite. Grant the permission (or assign the `json_api_user` role) to the roles/consumers that should be allowed to use JSON:API; leave it off `anonymous`/`authenticated` to close the API to the public.

---

- Close JSON:API to anonymous traffic while leaving it available to a trusted integration role.
- Require an explicit permission before any JSON:API endpoint responds, instead of core's open-by-default behavior.
- Restrict a decoupled front-end's API access to a dedicated `json_api_user` role/consumer.
- Give an OAuth/Simple OAuth consumer (via its role) access to JSON:API without opening it site-wide.
- Layer a coarse allow/deny gate on top of core entity access for defense-in-depth.
- Turn JSON:API into an authenticated-only API by granting the permission to `authenticated` but not `anonymous`.
- Grant a headless mobile app's service account access to JSON:API through a single permission.
- Quickly lock down JSON:API during an incident by revoking the permission from all roles.
- Use the shipped `json_api_user` role as a ready-made "API client" role.
- Prevent scraping of content via unauthenticated JSON:API collection endpoints.
- Enforce that only Basic Auth / key-authenticated roles can reach JSON:API.
- Segment JSON:API access per role in a multi-role site (e.g. partners vs. public).
- Keep JSON:API enabled for internal use while blocking external discovery of its routes.
- Audit which roles can use JSON:API by checking who holds `access jsonapi routes`.
- Combine with core's read-only JSON:API mode for a locked-down, permissioned, read-only API.
- Add an access prerequisite to custom JSON:API-flagged routes (anything with `_is_jsonapi`) automatically.
- Re-enable API access for a specific consumer by assigning the role, without editing route code.
