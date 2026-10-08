# JSON:API Role Access — agent index

A site-wide role gate over core JSON:API. One kernel REQUEST subscriber denies (Allow mode)
or blocks (Restrict mode) `jsonapi.*` routes by the current user's roles. Deny-only: it can
throw 403 but never grants access core would refuse. Depends on core `jsonapi`.

- **Config keys, modes, default install state, the settings form** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config object `jsonapi_role_access.settings`: `negate` (bool — FALSE=Allow, TRUE=Restrict),
  `roles` (sequence of role ids). Default install: `negate: FALSE`, `roles: {authenticated}`
  → blocks anonymous JSON:API.
- Enforced by `src/EventSubscriber/CheckUserRolePermissionEvent::checkUserRoleAccess()`
  (`KernelEvents::REQUEST`, priority 30). Allow: 403 unless user has ANY selected role.
  Restrict: 403 if user has ANY selected role.
- Only applies to routes whose `_route` starts with `jsonapi`; skips `jsonapi.settings`,
  `jsonapi_extras.settings`, `jsonapi_role_access.config`.
- Settings form: `/admin/config/services/jsonapi/role_access`, route
  `jsonapi_role_access.config`, permission `jsonapi role access`.
- Direction: **tightens** access only.
