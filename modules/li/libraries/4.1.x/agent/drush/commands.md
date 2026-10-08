# Drush

Legacy **Drush 8** integration via `libraries.drush.inc` (a `hook_drush_command`, not a modern
`drush.services.yml`/`src/Drush` command — it will not run under Drush 9+ unmodified).

- `drush libraries-list` — lists every registered library with Name, Status (OK / error), Version,
  installed Variants, and Dependencies. Reads through `\Drupal::service('libraries.manager')`.
- Registers a `libraries` cache-clear type: `drush cache-clear libraries` (Drush 8) empties the
  `libraries` cache bin (`\Drupal::cache('libraries')->deleteAll()`).
- A `libraries-download` callback exists in the file but is stubbed/non-functional (`return;`).

No permissions, no config UI — this is the module's only CLI surface.
