<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Default Content Tools (default_content_tools) — agent index

Operator controls over Drupal core's **Default Content API** and **recipe** system: globally
**suppress** default-content import, and **delete** content a module/recipe already imported.
Package `Content`. Core `^10 || ^11`. License GPL-2.0-or-later. Installed version `1.0.0-beta4`.
No info.yml module dependencies; uses core's `Drupal\Core\DefaultContent` and `Drupal\Core\Recipe`
APIs. Optional integration with contrib `recipe_tracker` (conditional service).

- **Settings, config object + schema, the delete list** → [config/settings.md](config/settings.md)
- **Suppress import, delete service, delete form/route, hooks, event subscribers** → [api/deletion.md](api/deletion.md)
- **Recipe config actions (mark/unmark for deletion)** → [plugins/config-actions.md](plugins/config-actions.md)

## What it provides (from source)

- **1 config object**: `default_content_tools.settings` — keys `suppress_import` (bool) and
  `delete_recipes` (sequence of recipe machine names). Schema in
  `config/schema/default_content_tools.schema.yml`; install defaults `suppress_import: false`,
  `delete_recipes: []`.
- **2 routes** (`default_content_tools.routing.yml`):
  - `default_content_tools.settings` — `/admin/config/content/default-content-tools`, `SettingsForm`,
    perm `administer site configuration`.
  - `default_content_tools.delete_form` — `/admin/modules/default-content-delete`,
    `DefaultContentDeleteForm` (a `ConfirmFormBase`), perm `administer modules`.
- **1 service**: `Drupal\default_content_tools\DefaultContentDelete` (autowired, logger-aware) —
  deletes entities named in a `Finder`'s content folder by UUID.
- **3 event subscribers**: `DefaultContentImport` (core `PreImportEvent` → skip all),
  `RecipeContentCleanup` (core `RecipeAppliedEvent` → delete a listed recipe's content),
  `RecipeTrackerCatchup` (registered only when `recipe_tracker` is installed — see
  `DefaultContentToolsServiceProvider`).
- **2 hooks** (attribute-based, `src/Hook/`): `Module::formAlter` (`hook_form_system_modules_alter`
  adds a per-module "Default Content" delete link on Extend) and `RecipeTracker::addOperation`
  (`hook_entity_operation` adds a "Delete default content" op on `recipe_tracker_log` entities).
- **2 config actions** (`src/Plugin/ConfigAction/`): `markRecipeContentForDeletion` /
  `unmarkRecipeContentForDeletion` — additively edit `delete_recipes`.
- **No permissions of its own**, no Drush commands, no new plugin *types*, no submodules.

## Access & safety (from source)

Both destructive paths require admin-level core permissions (`administer modules` for deletion,
`administer site configuration` for settings); deletion runs through a `ConfirmFormBase`. Deletion
loads each entity by UUID via the entity repository and is idempotent (no-op if already gone),
logging every deletion/failure to the `default_content_tools` logger channel.
