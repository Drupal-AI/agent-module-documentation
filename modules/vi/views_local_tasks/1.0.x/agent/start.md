<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Local Tasks — agent index

Turn a Views **Page** display into a second-level menu tab (local task) and optionally place it as a
local task under any parent route — configured entirely in the Views Menu settings, no
`*.links.task.yml` needed. Depends on `views` (Menu UI recommended for the parent selector). No config
schema files (it extends `views.display.page` via an alter hook), no permissions, no Drush, no
settings page.

- **The extra Menu options, what they store, and how the local task is built at runtime** →
  [configure/local-tasks.md](configure/local-tasks.md)

Key facts:
- Replaces the core `page` display plugin class with `PageWithLocalTasks` (`hook_views_plugins_display_alter`).
- Adds view options: `as_local_task`, `local_task_link_title`, `local_task_parent`,
  `local_task_custom_parent_route`, `local_task_weight` (schema added via `hook_config_schema_info_alter`).
- `CustomViewsLocalTask` (subclass of core `ViewsLocalTask`) runs in `hook_local_tasks_alter`; the module's
  alter hook is forced to run last via `hook_module_implements_alter`.
