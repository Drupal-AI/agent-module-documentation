<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Toolbar integration

Adds the current page's local task tabs to Drupal's admin toolbar, in one of three styles.

## Hook & service

- `entity_tasks_toolbar_alter(&$items)` (`entity_tasks.module`) delegates to service
  `entity_tasks.toolbar` → `ToolbarService::buildToolbarConfiguration($items)`.
- Service `ToolbarService` — `src/Service/ToolbarService.php`. Args (`entity_tasks.services.yml`):
  `plugin.manager.menu.local_task`, `current_route_match`, `config.factory`, `router.admin_context`,
  `current_user`, `string_translation`.

## buildToolbarConfiguration()

Runs only when **both**: the route is **not** an admin route (`AdminContext::isAdminRoute()` is
false) **and** the current user has **`access entity tasks`**. It then reads the display mode and
dispatches:

- `classic` → `addClassicItems()`
- `expanded` → `addExpandedItems()`
- `dropdown` → `addDropdownItems()`
- anything else (including `-1` / "Disabled") → no toolbar item.

## Display modes

- **classic** (`ENTITY_TASKS_CLASSIC_DISPLAY_MODE = 'classic'`): a single `toolbar_item` with a
  "Tasks" button and a tray themed `links__entity_tasks`, library `entity_tasks/toolbar`.
- **expanded** (`'expanded'`): one `toolbar_item` **per link** (links `array_reverse`d for order);
  each tab is a `#type => link` with class `toolbar-icon-entity-tasks-<routeClass>`, where
  `getRouteNameClass()` maps `.`→`--` and `_`→`-`. Library `entity_tasks/toolbar`.
- **dropdown** (`'dropdown'`): a "Tasks" button whose tray is themed `entity_tasks_dropdown`,
  library `entity_tasks/dropdown`; `js/entity-tasks.dropdown.js` removes the `trigger` class so the
  hover CSS reveals the list.

All items use `#weight => 1000` and `#cache` context `url.path`.

## Link source & access filtering

`getLinks()` calls `localTaskManager->getLocalTasks(currentRoute, 0)` and, for each entry in
`['tabs']`, appends `$link['#link']` **only if** `$link['#access']` is a
`Drupal\Core\Access\AccessResultAllowed` — so a user only ever sees tabs core already granted them.

## Default-mode side effect

`getCorrectDisplayMode()` reads `display_mode` from config `entity_tasks.config`; if it is `NULL` it
falls back to `classic` and writes a default back to the config object. See
[../config/settings.md](../config/settings.md).

## Templates

- `templates/entity-tasks-dropdown.html.twig` — a `<ul class="entity-tasks-dropdown">` looping
  `links` as `<a href="{{ link.url }}">{{ link.title }}</a>` (Twig autoescaped).
- classic tray uses core's `links` theme (`links__entity_tasks`).
