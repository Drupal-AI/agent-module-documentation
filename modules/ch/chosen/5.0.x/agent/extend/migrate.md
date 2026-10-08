# Migration (Drupal 7 → current)

Chosen ships a migration to carry Drupal 7 Chosen configuration forward:

- Migration definition: `migrations/d7_chosen_settings.yml`.
- Process plugin: `src/Plugin/migrate/process/Chosen.php` (transforms legacy values to the new
  `chosen.settings` schema).
- `chosen_migration_plugins_alter()` (in `chosen.module`) adjusts migration plugin definitions
  so the settings map correctly during a D7 upgrade.

Run as part of a standard `drush migrate:import` upgrade; the settings land in the
`chosen.settings` config object (see [../configure/settings.md](../configure/settings.md)).
