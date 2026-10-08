# Role Expire — agent index

Makes user roles time-limited: each user's role can have an expiration timestamp; a cron run
removes the role (optionally swapping in a replacement) when it passes. State lives in the
`role_expire` DB table plus the `role_expire.config` settings object. Ships the
`role_expire_rules` submodule (documented separately).

- **Settings form, config keys, default per-role durations, per-user expiry, permissions** →
  [configure/settings.md](configure/settings.md)
- **The `role_expire.api` service, the DB table, cron expiry, the RoleExpiresEvent** →
  [api/service.md](api/service.md)

Key facts:
- Configure route (`configure`): `role_expire.config` → `/admin/config/people/role-expire`.
- Config object `role_expire.config`: `role_expire_disabled_roles`, `role_expire_default_duration_roles`
  (map rid → strtotime string), `role_expire_default_roles` (rid → replacement rid),
  `role_expire_expiration_details_expanded`.
- Per-user expiry is in the `role_expire` table (`uid`, `rid`, `expiry_timestamp`), NOT in config.
- Durations are strtotime strings (`1 day`, `3 months`, `1 year`) or absolute `YYYY-MM-DD HH:MM:SS`.
- `role_expire_cron()` removes expired roles and dispatches `RoleExpiresEvent`
  (`role_expire_event_role_expires`).
- Permissions: `administer role expire`, `edit users role expire`, `edit role expire default duration`.
