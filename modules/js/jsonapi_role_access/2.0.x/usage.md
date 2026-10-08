JSON:API Role Access adds a site-wide, role-based gate on top of core JSON:API: it denies (or, inverted, allows only) requests to `jsonapi.*` routes based on whether the current user holds any of a selected set of roles.

---

The module registers one kernel `REQUEST` event subscriber (`CheckUserRolePermissionEvent`, priority 30) that runs on every request. For requests whose route name starts with `jsonapi` (excluding the module/JSON:API settings routes), it reads two config values — `negate` (Allow vs Restrict mode) and `roles` (a set of role ids) — and compares them to the current user's roles. In **Allow** mode (`negate = FALSE`, the default) only users holding at least one selected role pass; everyone else gets a `403`. In **Restrict** mode (`negate = TRUE`) users holding any selected role are the ones blocked. The check succeeds on ANY-of matching (role intersection is non-empty). It is a **deny-only overlay**: it can only throw `AccessDeniedHttpException`, never grant access that core JSON:API entity/field access would otherwise refuse — so it tightens, never loosens, exposure. The default install config is Allow mode with the `authenticated` role selected, which blocks anonymous JSON:API access. A single settings form at `/admin/config/services/jsonapi/role_access` (permission `jsonapi role access`) configures mode and roles.

---

- Block anonymous users from reading any JSON:API resource (default Allow + authenticated).
- Restrict a decoupled/JSON:API front end so only specific roles can call the API.
- Allow only an "api_consumer" service role to reach `jsonapi.*` routes.
- Deny a specific role (e.g. a low-trust "guest" role) from the JSON:API while allowing others.
- Add a coarse role gate in front of JSON:API without writing custom access code.
- Lock down JSON:API on a site that only uses it for internal/authenticated integrations.
- Require login before any JSON:API collection or individual resource is reachable.
- Combine core JSON:API entity access with an extra role requirement layer.
- Quickly disable public JSON:API exposure by selecting only privileged roles in Allow mode.
- Switch between "allow these roles" and "block these roles" semantics from one form.
- Apply the same role gate to JSON:API Extras routes (also matched by the `jsonapi` prefix).
- Enforce that only editors/admins can use JSON:API write operations by role.
- Prevent scraping of content via JSON:API by anonymous clients.
- Gate a headless mobile app's API access to holders of an app-specific role.
- Roll out JSON:API to a subset of roles during a phased decoupling migration.
- Keep JSON:API enabled for core-required reasons while denying general access by role.
