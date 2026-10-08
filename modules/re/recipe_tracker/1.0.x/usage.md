Recipe Tracker records a log entry every time a Drupal recipe is applied to the site, capturing the recipe name, its Composer package and version, who applied it, and when — building an audit trail of recipe provenance since the module was installed.

---

The module defines one content entity type, `recipe_tracker_log` (`src/Entity/Log.php`), with fields `recipe_label`, `package_name`, `version`, `uid` (owner) and `created`. An event subscriber (`RecipeTrackerSubscriber`) listens for core's `RecipeAppliedEvent`: on each applied recipe it creates a Log entity, sets the owner to the current user, stores the recipe's name, resolves the Composer package (`drupal/core` when the recipe lives under `core/recipes/`, otherwise the `name` from the recipe's `composer.json`) and looks up the installed pretty version via `Composer\InstalledVersions` (falling back to `@dev`). The logs are browsable through an admin entity UI — a collection list at `/admin/modules/recipe-log` (menu placed under *Extend*), a canonical view page, and delete / delete-multiple forms — all gated by the single, `restrict access: true` permission `administer recipe_tracker_log`. A bundled `system.action` (`recipe_tracker_log_delete_action`) enables bulk deletion from the list builder. There is no settings form (`configure` is null), no config schema, no Drush commands, and no plugin types. Requires Drupal 11 core's Recipe system; no contrib dependencies.

---

- Keep an audit trail of which recipes have been applied to the site.
- Record the exact Composer package and version behind each applied recipe.
- Attribute each recipe application to the user who ran it.
- See the timestamp of when each recipe was applied.
- Review recipe history when debugging unexpected configuration changes.
- Verify in production which recipes a deployment actually applied.
- Distinguish core recipes (`drupal/core`) from contrib/custom recipe packages.
- Track repeated applications of the same recipe over time.
- Provide provenance for config that a recipe installed.
- Browse all recipe applications from an admin list under *Extend*.
- View a single recipe-application record on its canonical page.
- Bulk-delete old recipe log entries via the built-in delete action.
- Delete an individual recipe log entry through its delete form.
- Gate all recipe-log access behind a single restricted admin permission.
- Support non-ASCII recipe names (label column widened to utf8mb4).
- Audit which team member applied a recipe during a release.
- Confirm a recipe's version matches the intended release before sign-off.
- Feed recipe-application history into a change-management / compliance review.
- Detect whether a recipe was applied from core vs a custom package path.
- Retain recipe history independently of Composer/Git state on the server.
