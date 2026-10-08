# Configure Sticky Local Tasks

Settings form `Drupal\sticky_local_tasks\Form\StickyLocalTasksForm` at
`/admin/config/user-interface/sticky-local-tasks` (route `sticky_local_tasks.admin_settings`, form id
`sticky_local_tasks_admin_settings`). It edits the single config object `sticky_local_tasks.settings`.
Menu link `sticky_local_tasks.configuration` sits under `system.admin_config_ui`.

## Usage modes (`usage`)

The radio `Usage` chooses how the tabs get onto pages (schema `Choice: all | block`):

| Value | Behavior |
|---|---|
| `all` | `hook_page_bottom()` calls `StickyLocalTasksBuilder::addToPage()`, adding the tabs to every front-end page. The `usage_options` below apply. |
| `block` | Nothing is auto-added. Show the tabs only where you place the **Sticky primary tabs** block (see [blocks/block.md](../blocks/block.md)) or call the builder from custom code (see [api/builder.md](../api/builder.md)). |

The `usage_options` fields only render (and only apply) when `usage` is `all`; the mode switch is an
AJAX callback (`::usageOptionsCallback`). In `block` mode `usage_options` is stored empty.

## `usage_options` fields (mode `all`)

| Form field | Config key (`usage_options.*`) | Type / default | Effect |
|---|---|---|---|
| Hide default local tasks | `hide_default_local_tasks` | bool, default `true` | Attaches library `sticky_local_tasks/hide-default-local-tasks`, which visually hides `.block-local-tasks-block` (CSS clip). Themes using other markup may need extra CSS. |
| Show on admin pages | `show_on_admin` | bool, default `false` | When false, `addToPage()` skips admin routes (`AdminContext::isAdminRoute()`). Enabling is "not recommended" per the field help. |
| Remember sticky toggle state | `remember_toggled_state` | bool, default `false` | Passed to JS as `drupalSettings.stickyLocalTasks.rememberToggledState`; when on, the open/closed state is stored in browser `localStorage` key `Drupal.sticky_local_tasks.shown`. |
| Use Gin theme colors | `use_gin_colors` | bool, default `false` | Also attaches library `sticky_local_tasks/gin` and adds class `gin-colors`, mapping the widget's CSS variables to Gin's palette. |
| Use dark theme | `use_dark_theme` | bool, default `false` | Adds class `dark-theme`, forcing the dark palette regardless of system preference. |
| Preferred position | `static_position` | string, default `bottom-right` | `bottom-right` or `bottom-left` (validated against `Position::values()`). |

The top-level `usage` and every `static_position` radio is `#required`.

## Runtime gate (mode `all`)

`StickyLocalTasksBuilder::addToPage()` always tags `config:sticky_local_tasks.settings` cache, then
returns early unless `usage === 'all'`. When `all`, it adds a `route` cache context and skips the
widget when the route is one of `user.login`, `user.register`, `user.pass`, or (unless `show_on_admin`)
any admin route. `build()` additionally renders nothing unless the route has **>= 2** visible local
tasks (`Element::getVisibleChildren`). Position falls back to `Position::BottomRight` if the stored
value is invalid.

## Default config

`config/install/sticky_local_tasks.settings.yml`:

```yaml
usage: all
usage_options:
  hide_default_local_tasks: true
  show_on_admin: false
  static_position: bottom-right
  remember_toggled_state: false
  use_gin_colors: false
  use_dark_theme: false
```

## Set it with Drush / PHP

```bash
drush config:set sticky_local_tasks.settings usage all -y
drush config:set sticky_local_tasks.settings usage_options.static_position bottom-left -y
drush config:set sticky_local_tasks.settings usage_options.use_dark_theme true -y
```

```php
\Drupal::configFactory()->getEditable('sticky_local_tasks.settings')
  ->set('usage', 'all')
  ->set('usage_options.hide_default_local_tasks', TRUE)
  ->set('usage_options.show_on_admin', FALSE)
  ->set('usage_options.static_position', 'bottom-right')
  ->set('usage_options.use_gin_colors', FALSE)
  ->set('usage_options.use_dark_theme', FALSE)
  ->save();
```

## Config schema

`config/schema/sticky_local_tasks.schema.yml` types `sticky_local_tasks.settings` as a `config_object`
whose `usage_options` is a dynamic type `sticky_local_tasks.usage.[%parent.usage]` — so `usage: all`
resolves to the mapping above, and `usage: block` resolves to an empty mapping. It also defines
`block.settings.sticky_local_tasks` (a `block_settings` with a `position` string) for the block plugin.

## Upgrading from 1.x

`sticky_local_tasks_update_10201` migrates the old `static_position` / `default_local_tasks` keys into
`usage: all` + the `usage_options` shape; `_10202` backfills `usage_options.hide_default_local_tasks`.
Run `drush updatedb` after upgrading (clear the container cache if you hit a theme-registry TypeError).
