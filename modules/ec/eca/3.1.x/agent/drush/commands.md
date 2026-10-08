# Drush commands

From `src/Drush/Commands/EcaCommands.php`.

- **`drush eca:subscriber:rebuild`** — rebuilds the list of Drupal events ECA subscribes to.
  Run after adding/removing event plugins or importing models that use new events (it also runs
  during a cache rebuild, `drush cr`).

That is the command ECA Core registers. Individual submodules may add their own commands; check
each submodule's `src/Drush` if present.
