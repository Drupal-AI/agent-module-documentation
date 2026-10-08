# extlink — agent start

JavaScript module that decorates off-site + `mailto:`/`tel:` links (icon, new-window,
`nofollow`/`noreferrer`, click warning). No dependencies. Config UI:
**Admin → Config → User interface → External Links** (`/admin/config/user-interface/extlink`,
route `extlink_admin.settings`). All behavior lives in the `extlink.settings` config object;
core PHP just injects it as `drupalSettings` (or an external JS file).

- Settings keys & config object → [configure/settings.md](configure/settings.md)
- Alter settings in code → [hooks/hooks.md](hooks/hooks.md)
- Permission → [permissions/permissions.md](permissions/permissions.md)
- Override icon/link markup in a theme → [theming/overrides.md](theming/overrides.md)
