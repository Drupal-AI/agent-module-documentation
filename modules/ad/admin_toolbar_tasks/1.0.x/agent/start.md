<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin Toolbar Tasks (admin_toolbar_tasks) — agent index

Moves administrative **local tasks** (the View / Edit / Revisions / Translate style tabs) off the
content area and into a dropdown on the site **toolbar**. Version `1.0.3` (dir `1.0.x`).
Core `^9.3 || ^10 || ^11`, PHP `>=7.4`. Package `Administration`. License GPL-2.0-or-later.

## Dependency
- `drupal:toolbar` (core Toolbar module) — hard dependency.
- Works well alongside `admin_toolbar` (not required).

## What it provides (no routes, no permissions, no config, no services, no install)
- **`hook_toolbar()`** — adds one `toolbar_item` (`admin_toolbar_tasks`, weight 1000, floated right)
  whose contents are a lazy builder (`#create_placeholder`, cached by `route`), attaching the
  `admin_toolbar_tasks/toolbar.item` library.
- **`hook_menu_local_tasks_alter()`** — on **non-admin** routes (front-end theme), marks each tab
  that points at an admin route, stashes its original `#access`, and hides it from the normal tab
  block by setting `#access` to `AccessResult::forbidden()`.
- **`AdminToolbarTasksBuilder`** (`src/AdminToolbarTasksBuilder.php`) — trusted `#lazy_builder`
  callback that re-collects those marked tasks and renders the access-allowed ones as toolbar links.
- **`hook_theme()`** — theme hook `links__admin_toolbar_tasks` (base hook `links`), template
  `templates/links--admin-toolbar-tasks.html.twig` (renders a `⋮` toggle + `<ul>` when >1 link).
- **Library** `toolbar.item` — `css/admin-toolbar-tasks.css` only (no JS, no external deps).

Access is preserved end-to-end: a task appears in the toolbar only when its original per-route
access result `->isAllowed()`, so what a user sees still varies by permission.

## Solution docs
- [Mechanism, builder & theming](api/builder.md) — how the alter + lazy-builder + template fit
  together, cacheability, and how to override the markup/CSS.
