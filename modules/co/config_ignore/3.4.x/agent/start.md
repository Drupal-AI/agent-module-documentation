# config_ignore — agent start

Keeps selected configuration from being overwritten by `drush config:import` / `config:export`.
No module dependencies. Config UI: **Admin → Config → Development → Configuration → Ignore**
(`/admin/config/development/configuration/ignore`, route `config_ignore.settings`), gated by
core's `import configuration` permission. Works by subscribing to core config storage-transform
events; stores rules in `config_ignore.settings`.

- Define ignore patterns, modes, and settings.php overrides → [configure/settings.md](configure/settings.md)
- Add/alter ignore rules in code (hooks) → [hooks/hooks.md](hooks/hooks.md)
- Drush: full import/export bypass flag → [drush/drush.md](drush/drush.md)
