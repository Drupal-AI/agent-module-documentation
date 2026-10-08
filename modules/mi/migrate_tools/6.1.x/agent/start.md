# migrate_tools — agent start

Runs & manages core Migrate API migrations via Drush + an admin UI. Depends on core
`migrate`; the UI additionally needs `migrate_plus` (for the migration/migration_group
config entities). One permission gates everything: `administer migrations`.

- Drush commands (import/rollback/status/messages/stop/reset/tree/fields-source) → [drush/commands.md](drush/commands.md)
- Admin UI: migration groups & migrations, config UI route → [configure/ui.md](configure/ui.md)
- Permission → [permissions/permissions.md](permissions/permissions.md)
- Share source/process config across migrations (plugin) → [plugins/shared-configuration.md](plugins/shared-configuration.md)
