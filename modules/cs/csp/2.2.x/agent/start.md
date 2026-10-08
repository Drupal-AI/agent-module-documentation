# csp — agent start

Emits `Content-Security-Policy` / `-Report-Only` headers. Two configurable policies
(report-only + enforce), auto-discovers hosts from asset libraries, supports nonces/hashes,
Trusted Types, and pluggable reporting. Config UI: **Admin → Config → System → Content
Security Policy** (`/admin/config/system/csp`, route `csp.settings`).

- Configure the two policies, directives, reporting → [configure/settings.md](configure/settings.md)
- Alter a policy at runtime (event + theme hook) → [extend/events.md](extend/events.md)
- Build/manipulate a policy in code; nonces & hashes → [api/policy.md](api/policy.md)
- Add a custom reporting handler (plugin) → [plugins/handler.md](plugins/handler.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
