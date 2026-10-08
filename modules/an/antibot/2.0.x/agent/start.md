# antibot — agent start

Blocks spam bots by requiring JavaScript to submit protected forms (rewrites the form
`action` to `/antibot` + a secret key that JS restores). No CAPTCHA, no deps. Config UI:
**Admin → Config → User interface → Antibot** (`/admin/config/user-interface/antibot`,
route `antibot.settings`).

- Choose which forms are protected / excluded, debug form IDs → [configure/settings.md](configure/settings.md)
- Toggle protection, react to rejections, alter key via hooks → [hooks/hooks.md](hooks/hooks.md)
- Permissions (`administer antibot configuration`, `skip antibot`) → [permissions/permissions.md](permissions/permissions.md)
- Theme the no-JS warning message → [theming/theming.md](theming/theming.md)
