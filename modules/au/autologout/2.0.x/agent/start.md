# autologout — agent start

Idle-session timeout: logs users out after inactivity, with an optional warning dialog and
per-role/per-user thresholds. No module dependencies (bundles a JS cookie lib). Config UI:
**Admin → Config → People → Automated logout** (`/admin/config/people/autologout`, route
`autologout.set_admin`).

- Settings form + per-role/per-user timeouts (`autologout.settings`, `autologout.role.*`) → [configure/settings.md](configure/settings.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
- Programmatic timeout/logout via `autologout.manager` service → [api/manager.md](api/manager.md)
- Alter behavior (prevent logout, refresh-only, post-logout) via hooks → [hooks/hooks.md](hooks/hooks.md)
