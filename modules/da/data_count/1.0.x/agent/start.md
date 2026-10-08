<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Data Count (data_count) — agent index

A single **admin report page** at `/admin/reports/data-count` that counts nodes per content type
(published / unpublished / total) and users per custom role (active / inactive / total), with grand
totals. Every count links to the matching filtered `admin/content` / `admin/people` listing.
No config, no permissions of its own, no plugins, no Drush. Core requirement `^8.8 || ^9 || ^10 || ^11`.
License GPL-2.0-or-later. Version 1.0.4 (dir 1.0.x). Package: none declared.

- **The report route, the counting helpers, theming and how to operate it** →
  [page/data-count.md](page/data-count.md)

## What it actually is

- One route `data_count.admin_link` (`data_count.routing.yml`): path `/admin/reports/data-count`,
  `_controller: DataController::dataCount`, gated by `_permission: 'administer site configuration'`.
- One menu link (`data_count.links.menu.yml`) under `system.admin_reports` (Reports).
- One controller `src/Controller/DataController.php` — `DataController::dataCount()` returns a render
  array `#theme => 'data_count'` with `#data` and attaches library `data_count/count-style`.
- Counting logic lives in procedural helpers in `data_count.module`, not in a service:
  `data_count_node()`, `data_count_node_wise($type,$status)`, `data_count_user()`,
  `data_count_role_wise($role,$status)`, `data_count_users_sum($role,$status)`.
- `hook_theme()` registers the `data_count` theme (template `templates/data-count.html.twig`,
  variable `data`). `hook_help()` provides the help-page text.
- Library `count-style` (`data_count.libraries.yml`): `css/count.css` + `js/count.js`
  (depends on `core/drupal`, `core/jquery`); the JS toggles the node/user panels on click.

## Dependencies

- Drupal core **node** and **user** modules (used via `NodeType`, `Role`, and their data tables).
  No non-core dependencies; `composer.json require` is only `drupal/core`.

## What it does NOT provide

- No config objects/schema, no `*.permissions.yml`, no `*.services.yml`, no `*.install`,
  no config entities, no plugins, no Drush commands, no submodules. Read-only; stores nothing.
