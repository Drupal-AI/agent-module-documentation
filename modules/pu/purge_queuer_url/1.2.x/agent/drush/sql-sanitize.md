# Drush integration

The module registers **no standalone Drush command**. It ships one Drush *plugin* via
`drush.services.yml`:

- Service `purge_queuer_url.sqlsanitize.commands`, class
  `Drupal\purge_queuer_url\Commands\SqlSanitizeCommands`, tagged `drush.command`, arguments
  `@module_handler`, `@purge_queuer_url.registry`. Implements Drush's `SanitizePluginInterface`.

It hooks into the built-in **`drush sql:sanitize`** command:

| Hook | Method | Behavior |
|------|--------|----------|
| `@hook post-command sql-sanitize` | `sanitize()` | When the module is enabled, calls `registry->clear()` — wipes the URL/tag traffic tables. |
| `@hook on-event sql-sanitize-confirms` | `messages()` | Adds the confirmation line "Clear Purge URLs queuer traffic history." to the sanitize prompt. |

So running `drush sql:sanitize` (e.g. when sanitizing a production DB copy for a dev environment)
empties the traffic registry along with the other sanitizations. No arguments or options are
added. To clear the registry outside of sanitize, use the form's "Clear traffic history" button
(see configure/settings.md) or call `\Drupal::service('purge_queuer_url.registry')->clear()`.
