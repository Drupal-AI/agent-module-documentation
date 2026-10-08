# Migrate Booster — agent index

CLI-only migration accelerator: decorates `module_handler` to suppress configured hooks while
`drush migrate:import` / `migrate:rollback` run. Depends on core `migrate`, requires Drush 13,
Drupal 11.1+. No UI (`configure` null), no permissions, no config schema.

- **Config keys (`hooks`, `modules`) and settings.php examples** →
  [configure/settings.md](configure/settings.md)
- **Drush commands and the enable/reset lifecycle** → [drush/commands.md](drush/commands.md)

Key facts:
- Decorator `MigrateBoostModuleHandler` (priority 10) filters `hasImplementations`/`invoke*`
  when `MigrateBoost::isBoostActive()`.
- Boost is force-OFF on every `kernel.request` (`HooksEnablerSubscriber`), and turned ON via
  Drush `pre-command` hooks on `migrate:import` / `migrate:rollback`.
- Config object `migrate_boost.settings`: `hooks` (map hook→modules) and `modules` (list).
