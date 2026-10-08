<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Suppression, deletion service, form, hooks & subscribers

## Suppressing import — `DefaultContentImport`

`src/EventSubscriber/DefaultContentImport.php` subscribes to core
`Drupal\Core\DefaultContent\PreImportEvent`. On import it reads `suppress_import` from
`default_content_tools.settings`; if FALSE it returns. If TRUE it iterates `$event->finder->data`
and calls `$event->skip($uuid, ...)` for each item's `_meta.uuid`, skipping **every** discovered
item (per-item `\Throwable` is swallowed with `continue`). Constructed with `@config.factory`.

## The delete service — `DefaultContentDelete`

`src/DefaultContentDelete.php` (service id = FQCN, autowired, `LoggerAwareInterface`; the logger
`logger.channel.default_content_tools` is injected via a `setLogger` call in
`default_content_tools.services.yml`). Single method:

- `deleteContent(Finder $content)` — no-op if the folder has no data. For each item it reads
  `_meta.uuid` and `_meta.entity_type`, calls
  `EntityRepositoryInterface::loadEntityByUuid($entity_type_id, $uuid)`, and if found calls
  `$entity->delete()`, logging a `notice`. Per-item failures are caught and logged as `error`
  (with the reason). Idempotent: a missing entity simply isn't loaded, so re-running is safe.

`Finder` is core `Drupal\Core\DefaultContent\Finder`, pointed at an extension's `content/` folder;
it is the same input the core Default Content importer consumes, so deletion mirrors import exactly.

## The delete form / route — `DefaultContentDeleteForm`

`src/Form/DefaultContentDeleteForm.php` (a `ConfirmFormBase`, form id
`default_content_tools_delete`), route `default_content_tools.delete_form` at
`/admin/modules/default-content-delete`, permission **`administer modules`**. Question: "Are you
sure you want to delete default content?".

`submitForm()` resolves an extension path from the request query:
- `?package=<composer/package>` → `Composer\InstalledVersions::getInstallPath($package)`, or
- `?module=<machine_name>` → `module_handler->getModule($module)->getPath()`.

It then builds `new Finder($path . '/content')`; if the path is empty or the folder has no data it
adds an error and returns. Otherwise it calls `DefaultContentDelete::deleteContent()` and shows a
status message. (Access is enforced by the route permission; submission is via the confirm form.)

## Hooks (attribute-based, `src/Hook/`)

- `Module::formAlter` — `#[Hook('form_system_modules_alter')]`. Iterates the Extend form's module
  groups; for each **installed** module whose `content/` folder (`new Finder(path.'/content')`)
  has data, it adds a "Default Content" link pointing at `default_content_tools.delete_form` with
  `?module=<machine>` plus the current `destination`. Injected `@module_handler`.
- `RecipeTracker::addOperation` — `#[Hook('entity_operation')]`. Only for `recipe_tracker_log`
  entities: reads the log's `package_name`, verifies `InstalledVersions::getPrettyVersion()`
  matches the logged `version`, and that the package's `content/` folder has data; then adds a
  "Delete default content" operation linking to the delete form with `?package=<fqn>`. (Requires
  the contrib `recipe_tracker` module, which defines the `recipe_tracker_log` entity.)

## Automatic recipe cleanup — `RecipeContentCleanup`

`src/EventSubscriber/RecipeContentCleanup.php` subscribes to core
`Drupal\Core\Recipe\RecipeAppliedEvent`. `onRecipeApplied()` takes `basename($event->recipe->path)`
as the recipe machine name; if it is in `delete_recipes` and the recipe ships content, it calls
`DefaultContentDelete::deleteContent($event->recipe->content)`. This fires for **every** recipe
applied while the module is installed — including recipes applied later via Project Browser or
`drush recipe:apply` — so a listed recipe's content is removed the moment it finishes applying.
Constructed with `@config.factory` and the delete service.

## Catch-up pass — `RecipeTrackerCatchup` (conditional)

`src/EventSubscriber/RecipeTrackerCatchup.php` is registered **only when `recipe_tracker` is
installed**, by `DefaultContentToolsServiceProvider::register()` (checks
`container.modules` for `recipe_tracker` and registers
`default_content_tools.recipe_tracker_catchup` with `@config.factory`, `@entity_type.manager`,
`@DefaultContentDelete`, tagged `event_subscriber`).

On each `RecipeAppliedEvent`, if `delete_recipes` is non-empty it queries **all**
`recipe_tracker_log` entities (`getQuery()->accessCheck(FALSE)` — an internal maintenance sweep,
not a user-facing listing), resolves each log's `package_name` install path, and if
`basename($path)` is in `delete_recipes` and its `content/` folder has data, deletes that content.
This exists to cover the ordering gap where the recipe that *requested* deletion (e.g. a branded
parent recipe that installs this module) is applied **after** the recipe that *provided* the
content — whose `RecipeAppliedEvent` fired before any listener was registered. Deletion is
idempotent, so repeated sweeps are cheap.
