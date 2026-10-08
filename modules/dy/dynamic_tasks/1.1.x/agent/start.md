<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dynamic Local Tasks (dynamic_tasks) — agent index

Add local task **tabs** (primary/secondary) to any route from the admin UI instead of a module's
`*.links.task.yml`. Package: none declared (`configure: entity.local_task.collection`). No module
dependencies, no external libraries, no Drush. Core requirement `^9 || ^10 || ^11`. License
GPL-2.0-or-later. Version 1.1.5 (dir `1.1.x`).

- **Full how-it-works: the config entity, the form, the deriver, routes, permission, autocomplete,
  config schema, and how to operate/export it** → [config/local-tasks.md](config/local-tasks.md)

## What it actually is

- One **config entity type** `local_task` (`src/Entity/LocalTask.php`, config prefix
  `dynamic_local_task`, `admin_permission = "administer dynamic local tasks"`). Instances are
  managed at **`/admin/structure/menu/dynamic-tasks`** (`LocalTaskListBuilder`) and edited by
  `LocalTaskForm`.
- One **local-task deriver** `DynamicLocalTasks` (`src/Plugin/Derivative/DynamicLocalTasks.php`,
  wired via `dynamic_tasks.local_tasks` in `dynamic_tasks.links.task.yml`) that turns every
  `local_task` entity into a `menu.local_task` plugin derivative at runtime.
- One **route** `dynamic_tasks.autocomplete` (`/dynamic-tasks/autocomplete`,
  `LocalTaskAutocompleteController`) — searches the `router` table for route name/path suggestions.
- One **permission** `administer dynamic local tasks` (`restrict access: true`).
- **Config schema** for `dynamic_tasks.dynamic_local_task.*`. No `.module`, `.install`,
  `.services.yml`, or `config/install/` — nothing installed by default.

## Fields on the entity (config_export)

`id`, `label` (tab title), `route_name` (route the tab links to), `route_parameters`
(newline-separated `key=value`), `type` (`base_route` = primary tab, or `parent_id` = secondary
tab), `base_route`, `parent_id`, `weight`.

## Key mechanism (from source)

- `LocalTask::getRoute()` looks a route up via `router.route_provider`; `getRouteParameters()`
  parses the newline `key=value` textarea into an array; `getParent()` resolves a parent local
  task via `plugin.manager.menu.local_task`.
- `DynamicLocalTasks::getDerivativeDefinitions()` builds a derivative per entity with
  `title/route_name/route_parameters/weight` plus `base_route` OR `parent_id` per `type`.
- A rendered tab still goes through core's local-task access checks against its linked route, so it
  only appears to users who can already reach that route.
