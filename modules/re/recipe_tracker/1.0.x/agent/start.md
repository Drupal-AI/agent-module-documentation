# Recipe Tracker — agent index

Logs every applied Drupal recipe (name, Composer package, version, who, when) to a
`recipe_tracker_log` content entity, via a subscriber on core's `RecipeAppliedEvent`. Browsable
through an admin entity UI. Drupal 11 only; no contrib deps. No settings form, no Drush, no plugins.

- **The Log entity + fields, the auto-logging subscriber, routes, permission and the delete action** →
  [api/log.md](api/log.md)

Key facts:
- Entity `recipe_tracker_log` (`src/Entity/Log.php`): fields `recipe_label`, `package_name`, `version` (default `@dev`), `uid` (owner), `created`. `admin_permission = administer recipe_tracker_log`.
- Auto-log: `RecipeTrackerSubscriber::recipeApplied()` on `\Drupal\Core\Recipe\RecipeAppliedEvent` (`src/EventSubscriber/RecipeTrackerSubscriber.php`).
- Routes (AdminHtmlRouteProvider): collection `/admin/modules/recipe-log`, canonical `/admin/modules/recipe-log/{id}`, delete + delete-multiple. Menu under *Extend* (`system.modules_list`).
- Single permission `administer recipe_tracker_log` (`restrict access: true`) gates everything. Bundled `system.action` `recipe_tracker_log_delete_action` for bulk delete.
