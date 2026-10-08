# Recipe Tracker — entity, subscriber & routes

## The `recipe_tracker_log` entity (`src/Entity/Log.php`)

Content entity type, base table `recipe_tracker_log`, `admin_permission = administer recipe_tracker_log`,
uses `EntityOwnerTrait`. Implements `LogInterface` with setters `setRecipeName()`, `setPackageName()`,
`setVersion()`.

Base fields:

| Field | Type | Notes |
|---|---|---|
| `recipe_label` | string(255), required | recipe `name` from recipe.yml; label key. Widened to utf8mb4 by `update_10001` (non-ASCII names). |
| `package_name` | string(255), ascii | fully-qualified Composer package (`drupal/core` for core recipes). |
| `version` | string(32), required, ascii | installed pretty version; defaults to `@dev`. |
| `uid` | entity_reference → user | owner (who applied); defaults to current user, anonymous (0) if unset in `preSave`. |
| `created` | created | applied-on timestamp. |

Handlers: `list_builder` = `LogListBuilder` (sorts id DESC; columns Applied-by/Recipe/Version/Applied),
`views_data` = core `EntityViewsData`, delete forms = core `ContentEntityDeleteForm` /
`DeleteMultipleForm`, route provider = core `AdminHtmlRouteProvider`.

## Auto-logging (`src/EventSubscriber/RecipeTrackerSubscriber.php`)

Subscribes to `\Drupal\Core\Recipe\RecipeAppliedEvent`. On each event, `recipeApplied()`:

1. `Log::create()`, owner = `current_user`, `recipe_label` = `$event->recipe->name`.
2. Package: if `recipe->path` is under `<app_root>/core/recipes/` → `drupal/core`; else reads `<recipe path>/composer.json` and takes its `name`.
3. Version: `Composer\InstalledVersions::getPrettyVersion($package_name)`, falling back to `@dev` on failure.
4. `$log->save()`.

No API is exposed for *you* to call — logging happens automatically whenever a recipe is applied.

## Routes & UI

All from the entity's `links` via `AdminHtmlRouteProvider`, gated by `administer recipe_tracker_log`
(`restrict access: true`):

- `entity.recipe_tracker_log.collection` → `/admin/modules/recipe-log` (list; menu under *Extend*).
- `entity.recipe_tracker_log.canonical` → `/admin/modules/recipe-log/{recipe_tracker_log}` (view; "View" local task).
- `entity.recipe_tracker_log.delete_form` → `.../{id}/delete` ("Delete" local task).
- `entity.recipe_tracker_log.delete-multiple-form` → `/admin/modules/recipe-log/delete-multiple`.

## Bulk delete action

`config/install/system.action.recipe_tracker_log_delete_action.yml` — id
`recipe_tracker_log_delete_action`, plugin `entity:delete_action:recipe_tracker_log`, exposing a
"Delete logs" bulk operation on the list builder / Views.

## Permission

`recipe_tracker.permissions.yml`: **`administer recipe_tracker_log`** — title "Administer logs",
`restrict access: true`. The only permission; gates all entity routes and operations.
