# matomo — agent start

Injects the Matomo (Piwik) JS tracking snippet site-wide, with path/role/user visibility
rules and privacy options. Depends on core `path_alias`. Config UI: **Admin → Config →
System → Matomo Analytics** (`/admin/config/system/matomo`, route
`matomo.admin_settings_form`). Settings live in `matomo.settings`.

- All tracking settings (site id, URL, visibility, tracked events, privacy, custom vars,
  code snippets, local cache) → [configure/settings.md](configure/settings.md)
- Tokens, Views event tracking & CSP integration → [extend/integrations.md](extend/integrations.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)

Submodule: **matomo_tagmanager** (Matomo Tag Manager containers) — documented separately.
