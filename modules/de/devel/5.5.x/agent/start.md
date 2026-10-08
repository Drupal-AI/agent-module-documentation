# devel — agent start

Developer toolkit: variable dumpers, introspection pages, switch-user, config editor.
Dev-only. Config UI: **Admin → Config → Development → Devel** (`/admin/config/development/devel`,
route `devel.admin_settings`). Submodule: `devel_generate` (dummy content).

- Settings (dumper backend, error handler, mail log, toolbar) → [configure/settings.md](configure/settings.md)
- Dump/introspection helpers & services in code → [api/services.md](api/services.md)
- Register a custom variable dumper (plugin) → [plugins/dumper.md](plugins/dumper.md)
- Drush commands (`devel:token/hook/event/services/uuid/reinstall`) → [drush/commands.md](drush/commands.md)
- Alter dumper info via hook → [hooks/hooks.md](hooks/hooks.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
