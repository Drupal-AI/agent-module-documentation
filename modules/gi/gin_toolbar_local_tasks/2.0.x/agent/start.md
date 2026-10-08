<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gin Toolbar Local Tasks (gin_toolbar_local_tasks) — agent index

Moves the **current page's local task tabs** (Edit / View / Revisions / Translate …) into Drupal's
**administration toolbar**, as a single expandable "Local Tasks" menu item at the top of the admin
menu. Version **2.0.0**. Core requirement `^10 || ^11`. Depends only on core `toolbar`.

**Despite the name it does not need the Gin theme or the `gin_toolbar` module.** It alters core's
toolbar, so it works with any theme that uses the core toolbar (it just reads best on Gin, and pairs
well with Admin Toolbar). `gin_toolbar` is only *suggested*, for Gin's frontend toolbar. 1.x required
`gin_toolbar`; 2.x dropped that dependency. No configuration, no permission, no admin form.

## How it works (the whole module)

- **`gin_toolbar_local_tasks.module` → `hook_toolbar_alter()`** appends a `#pre_render` callback to
  `$items['administration']['tray']['toolbar_administration']`:
  `[GinToolbarLocalTasks::class, 'localTasks']`.
- **`src/GinToolbarLocalTasks.php` → `localTasks(array $build)`** (a `TrustedCallbackInterface`,
  registered in `trustedCallbacks()`):
  1. `\Drupal::service('plugin.manager.menu.local_task')->getLocalTasks(<current route>, 0)` — the
     primary local tasks for the current route.
  2. Sorts `$local_tasks['tabs']` by weight (`SortArray::sortByWeightProperty`).
  3. For each tab, **renders it only if `$local_task['#access']->isAllowed()`** — access filtering is
     done here, so tabs a user cannot reach are never emitted. Each kept tab gets
     `toolbar-icon`/`toolbar-icon-local-tasks` classes and a dummy `original_link` (a workaround so
     Admin Toolbar's link filter does not drop it).
  4. Remembers the `edit_form` task's route to use as the parent "Local Tasks" link target.
  5. Prepends a `local_tasks` menu item (expanded, `below` = the collected tabs) to
     `$build['administration_menu']['#items']`, keeping any `admin_toolbar_tools.help` item on top.
  6. Copies the local-task manager's cacheable metadata onto the build via `applyTo()`.

## Caching / access (why it is safe)

- Access is filtered at build time by the tab's own `#access` result — no admin-only tab leaks.
- `getLocalTasks()` cacheability seeds the `route` cache context and merges each tab's **access
  result** as a cacheable dependency, so the toolbar build inherits `route` + the access-derived
  contexts (typically `user.permissions`). Those bubble up with the toolbar render cache, so the
  relocated tabs vary per page and per user — no cross-user disclosure.
- Note (non-security correctness): the callback calls `$local_tasks['cacheability']->merge($metadata)`
  but discards the return value (`merge()` returns a new object, it does not mutate), so the toolbar
  sub-element's own pre-existing cache tags are not merged before `applyTo()` overwrites them. Effect
  is at worst a stale/under-tagged admin menu, not a permissions leak — `route` and the
  access-derived `user.permissions` still reach the cache.

## Limitations / direction

- Hooks the **classic** core toolbar. Core's `navigation` module is superseding the toolbar in newer
  releases; on a site switched to `navigation` there is no `administration` tray to alter, so this
  module has no effect there. Its longevity depends on that transition.
- Local tasks are navigation: after relocation they must stay keyboard reachable, with a visible
  focus indicator and the active tab distinguishable by more than colour (a theming concern, not
  something this module styles).

## Files

- `usage.md` — short / dense / use-case bullets.
- `data.json` — metadata. No config schema, no permissions, no libraries, no submodules.

Compare `workbench_tabs` and `admin_toolbar_messages`, which address the same tabs-placement problem
from different directions.
