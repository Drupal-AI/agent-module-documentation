<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, hooks, template, library & mapping API

## Route / permission / config

- Form `src/Form/SettingsForm.php` (extends `ConfigFormBase`, form id `admin_local_tasks_form`).
- Route `admin_local_tasks.settings`, path `/admin/config/user-interface/admin-local-tasks`,
  requirement `_permission: 'administer admin_local_tasks'` (the module's one permission, from
  `admin_local_tasks.permissions.yml`). Menu link under *Configuration → User interface*.
- Editable config object **`admin_local_tasks.settings`**:

  | Key | Values | Default | Meaning |
  |---|---|---|---|
  | `position` | `left` / `right` | `left` | Screen side the fixed tabs dock to. |
  | `tooltips` | `0` / `1` (select: Disabled/Enabled) | `0` | Show link title as a Tippy tooltip. |

  No `config/install` or `config/schema` ships — the object is created on first `submitForm()` save.
  `submitForm()` also calls `Cache::invalidateTags(['admin_local_tasks:settings'])`.

## `.module` hooks (all in `admin_local_tasks.module`)

- `admin_local_tasks_page_attachments_alter()` — attaches library `admin_local_tasks/base` only when
  the route is **not** an admin route (`router.admin_context->isAdminRoute()` is false) **and** the
  user is **not anonymous**. So the restyle applies to logged-in users on front-end routes only.
- `admin_local_tasks_preprocess_block__local_tasks_block()` — reads `admin_local_tasks.settings`, adds
  class `position-<position|left>` to the tabs block, adds class `tooltips` when `tooltips` is on, and
  adds cache tag `admin_local_tasks:settings` (so the save-time invalidation refreshes it).
- `admin_local_tasks_preprocess_menu_local_tasks()` — exposes `default_theme`, `admin_theme`
  (from `system.theme`) and `is_admin_route` to the template.
- `admin_local_tasks_preprocess_menu_local_task()` — for each tab: base icon class = `Html::getClass($link['title'])`;
  then, for a route-name→class `$mapping` (seeded `canonical→view`, `edit_form→edit`,
  `delete_form→delete`, and `\Drupal::moduleHandler()->alter('local_tasks_mapping', $mapping)`), if the
  route name ends with `.<key>` the class becomes the mapped value. Sets
  `data-tippy-content = $link['title']` and rewrites the title to `@title @icon` where `@icon` is a
  `FormattableMarkup('<span class="icon"></span>')`.
- `admin_local_tasks_theme_registry_alter()` — repoints `menu_local_tasks` template `path` to
  `<module>/templates/navigation`.
- `admin_local_tasks_local_tasks_mapping_alter()` — the module's own implementation of the alter hook
  below; seeds extra mappings: `user.edit_form→user`, `version_history→revisions`, `devel_load→settings`,
  `content_translation_overview`/`config_translation_overview→translate`,
  `scheduler_scheduled_content.user_page→scheduled`, `clone_form→clone`, `backlinks→linkplus`,
  `set_switch→shortcuts`, and several `webform*` routes (submissions/test/list/settings/export).

## Template

`templates/navigation/menu-local-tasks.html.twig` renders primary/secondary tabs. For logged-in users
on non-admin routes it uses `ul` classes `admin-local-tasks-tabs primary|secondary`; otherwise the
standard `tabs primary|secondary` classes. It attaches `olivero/tabs` when the relevant theme is Olivero.

## Library — `admin_local_tasks/base`

`admin_local_tasks.libraries.yml`:

```yaml
base:
  version: 1.1.0
  js:
    https://unpkg.com/@popperjs/core@2: { external: true }
    https://unpkg.com/tippy.js@6: { external: true }
    assets/js/tooltips.js: {}
  css:
    component:
      assets/css/base.css: {}
```

`assets/js/tooltips.js` (`Drupal.behaviors.adminLocalTasksTooltips`) initializes Tippy on
`.block-local-tasks-block.tooltips a[data-tippy-content]`, flipping placement to `left` when the block
has `position-right`.

## Extension API — `hook_local_tasks_mapping_alter(array &$mapping)`

Documented in `admin_local_tasks.api.php`. Other modules implement it to add/override route-suffix→icon
class mappings, e.g.:

```php
function mymodule_local_tasks_mapping_alter(array &$mapping) {
  $mapping['version_history'] = 'revisions';
}
```

The key is matched against the tab's route name with `preg_match('/\.<key>$/', $route_name)`; the value
becomes the CSS class used to select the icon (backed by SVGs in `assets/images/icons/` via `base.css`).

## Operating

1. Enable the module; ensure the core **Primary tabs / Local tasks** block is placed in the theme.
2. Grant `administer admin_local_tasks` to the intended role.
3. Configure position + tooltips at `/admin/config/user-interface/admin-local-tasks`; clear caches
   after enabling so the template registry override takes effect.
