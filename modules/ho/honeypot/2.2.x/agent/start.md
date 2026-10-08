# honeypot — agent start

Anti-spam via a hidden "honeypot" field + a minimum submit-time restriction; no CAPTCHA.
Auto-applies to forms per settings, or protect specific forms in code. No module deps.
Config UI: **Admin → Config → Content authoring → Honeypot** (`/admin/config/content/honeypot`,
route `honeypot.config`).

- Settings (protect-all vs per-form, time limit, field name, logging) → [configure/settings.md](configure/settings.md)
- Protect a form in code (`honeypot` service) → [api/service.md](api/service.md)
- Alter/react via hooks → [hooks/hooks.md](hooks/hooks.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
