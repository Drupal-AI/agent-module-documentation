# seckit — agent start

Adds/configures HTTP security headers (CSP, HSTS, clickjacking, referrer-policy, etc.) via an
event subscriber. Pure config — no API/plugins. Config UI: **Admin → Config → System →
Security Kit** (`/admin/config/system/seckit`, route `seckit.settings`, permission
`administer seckit`).

- All settings (CSP, HSTS, clickjacking, CSRF, referrer, feature-policy) → [configure/settings.md](configure/settings.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
