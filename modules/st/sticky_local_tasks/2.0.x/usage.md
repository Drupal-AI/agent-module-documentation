<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sticky Local Tasks re-renders a page's primary local task tabs — View, Edit, Revisions, Delete — as a small floating widget pinned to a corner of the viewport, so an editor part way down a long node does not have to scroll back to the top to switch tabs.

---

Local tasks normally render once near the top of the page and then scroll out of view, which on a long article or a Layout Builder screen means a lot of scrolling. This module rebuilds those same, already-access-checked tasks as a fixed, collapsible widget. `StickyLocalTasksBuilder` (service `sticky_local_tasks.builder`) reads core's local task list and produces a render array themed by two Twig templates (`menu-local-tasks--sticky-local-tasks.html.twig` and `menu-local-task--sticky-local-tasks.html.twig`); a small `core/once`-guarded behavior toggles the panel open and closed and can remember that state in `localStorage`; and a CSS library positions and styles it, with optional Gin-theme colors and a forced dark palette. A settings form at `/admin/config/user-interface/sticky-local-tasks` (route `sticky_local_tasks.admin_settings`, config object `sticky_local_tasks.settings`) chooses the usage mode — add it to every page (`all`) or only where you place the *Sticky primary tabs* block or call the builder from code (`block`) — plus the corner position, whether to hide the default tabs, whether to show on admin routes, and the color options. A `Position` enum expresses the two corners, and `hook_sticky_local_tasks_route_alter()` lets other modules map extra routes to tab icons. The widget only appears when a page has at least two visible tasks, and never adds a task the user could not already see. Requirements are PHP 8.1+ and core `^10 || ^11`; no other modules are required (the block mode uses core Block).

---

- Keep View/Edit tabs reachable while scrolling a long node.
- Reduce scrolling for editors on content-heavy pages.
- Pin the local tasks to the bottom-right or bottom-left corner.
- Speed up switching between View and Edit part way down a page.
- Improve the editing experience on Layout Builder screens.
- Make Revisions and Delete tabs reachable at any scroll depth.
- Add sticky tabs to every front-end page regardless of theme (`usage: all`).
- Show the tabs only where a *Sticky primary tabs* block is placed (`usage: block`).
- Render the tabs from custom code via `\Drupal::service('sticky_local_tasks.builder')->build(...)`.
- Hide the theme's default local-tasks block once the sticky widget is shown.
- Optionally show the widget on admin routes too.
- Remember the open/closed toggle state per browser via localStorage.
- Match the widget to the Gin admin theme's colors.
- Force a dark color palette regardless of system preference.
- Give custom or contrib local tasks an icon with `hook_sticky_local_tasks_route_alter()`.
- Restyle the widget by overriding its `--slt-*` CSS variables.
- Keep moderation/translation tabs in reach while reviewing long content.
- Avoid writing a custom theme override to achieve a sticky-tabs effect.
- Improve tab usability on small screens.
- Configure position and behavior without touching CSS.
- Limit the widget to certain pages or roles using core block visibility.
- Skip the widget automatically on login/register/password routes.
