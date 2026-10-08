<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin Local Tasks (admin_local_tasks) — agent index

Restyles the core **local-tasks (tabs) block** into a fixed, minimalistic **icon menu** pinned left or
right, for **logged-in users on non-admin routes** only. Optional Tippy.js tooltips. No dependencies.
Core `^8.8 || ^9 || ^10 || ^11`. Package `Navigation`. License GPL-2.0-or-later. Version 1.1.x.

- **Settings form, config keys, the preprocess hooks, the template, the library, and the
  `hook_local_tasks_mapping_alter()` API** → [config/settings.md](config/settings.md)

## What it actually is (from source)

- Hook-only module (`admin_local_tasks.module`), one config form `Form/SettingsForm` (route
  `admin_local_tasks.settings`, path `/admin/config/user-interface/admin-local-tasks`, permission
  **`administer admin_local_tasks`**).
- One permission (`admin_local_tasks.permissions.yml`): `administer admin_local_tasks`.
- Config object **`admin_local_tasks.settings`** (`position`: left|right, `tooltips`: 0|1). **No
  `config/install` and no `config/schema` ship** — keys are created on first save.
- One library `admin_local_tasks/base` (`assets/css/base.css`, `assets/js/tooltips.js`) plus **two
  external CDN scripts** declared in `admin_local_tasks.libraries.yml`.
- Template override `templates/navigation/menu-local-tasks.html.twig`; icon SVGs in `assets/images/icons/`.
- One documented alter hook: `hook_local_tasks_mapping_alter(array &$mapping)` (`admin_local_tasks.api.php`).
- **No routes beyond settings, no entities, no services, no plugins, no Drush, no submodules.**

## Mechanism (short, from `.module`)

- `hook_page_attachments_alter()`: attaches `admin_local_tasks/base` only when
  `!router.admin_context->isAdminRoute() && !currentUser->isAnonymous()`.
- `hook_preprocess_block__local_tasks_block()`: adds `position-<left|right>` and (if enabled) `tooltips`
  classes to the tabs block; adds cache tag `admin_local_tasks:settings`.
- `hook_preprocess_menu_local_task()`: derives an icon class from the link title via `Html::getClass()`,
  overridden by a route-name→class `$mapping` (canonical→view, edit_form→edit, delete_form→delete, …),
  sets `data-tippy-content` to the link title, and appends a `<span class="icon"></span>` (via
  `FormattableMarkup`) to the title.
- `hook_theme_registry_alter()` repoints the `menu_local_tasks` template to the module's `templates/navigation`.
- `hook_local_tasks_mapping_alter()` (own impl) seeds extra mappings (version_history→revisions,
  translate overviews→translate, clone_form→clone, several webform.* routes, …).
