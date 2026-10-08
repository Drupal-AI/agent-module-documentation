# config_update_ui — agent start

UI + Drush for config drift reports and revert/import, built on `config_update` services.
Depends on `config_update` + core `config`. Report UI: **Admin → Config → Development →
Configuration → Update report** (`/admin/config/development/configuration/report`, route
`config_update_ui.report`).

- Run reports & revert/import in the UI → [configure/ui.md](configure/ui.md)
- Do the same from the command line → [drush/commands.md](drush/commands.md)
- Permissions that gate reports/revert/delete → [permissions/permissions.md](permissions/permissions.md)
