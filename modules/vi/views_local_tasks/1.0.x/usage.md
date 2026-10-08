<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Local Tasks lets a Views Page display appear as a second-level menu tab (local task) and, optionally, attach itself as a local task under an arbitrary parent route — all from the Views menu settings UI, without writing a `*.links.task.yml` file.

---

The module swaps the core Views `page` display plugin for its own `PageWithLocalTasks` subclass (via `hook_views_plugins_display_alter`), which adds extra fields to the display's **Menu** options form when the menu type is "tab" and the Menu UI module is enabled: **Local task only** (`as_local_task`), **Local task link title** (`local_task_link_title`), **Local task parent** (`local_task_parent`, a select of applicable views/menu links plus a `_custom` option), **Local task custom parent route** (`local_task_custom_parent_route`), and **Local task weight** (`local_task_weight`). These options are persisted onto the view via `hook_config_schema_info_alter`, which extends the `views.display.page` schema mapping. At runtime `hook_local_tasks_alter` runs a `CustomViewsLocalTask` derivative (a subclass of core's `ViewsLocalTask`) that, for each menu-tab view, resolves the parent route from the display path, sets the tab's `base_route`, and — when a link title is given — creates an extra `views_view_local_task:` local task with the configured title, parent id (either a chosen route or the custom route string), and weight. If **Local task only** is checked, the normal menu item is removed so the view shows only as a local task. `hook_module_implements_alter` pushes this module's `local_tasks_alter` to run last so it can override other definitions.

---

- Show a Views page as a secondary tab (local task) on an existing admin/content page.
- Add a "Recent" or "Archived" tab next to core Content using a view, with no YAML.
- Attach a view as a local task under `system.admin_content` (the Content page).
- Attach a view as a local task under `entity.media.collection` (the Media page).
- Attach a view as a local task under `comment.admin` (the Comments page).
- Point a view's local task at another view's page as its parent tab.
- Use a custom parent route id (e.g. one defined in a module's `links.task.yml`) via the "Custom" option.
- Give the local task a display title different from the menu link title.
- Control the ordering of sibling tabs with a per-view local task weight.
- Render a view as a local task ONLY, hiding it from the regular menu (`Local task only`).
- Group several related views as tabs under one parent page.
- Build an admin section with multiple report views exposed as tabs.
- Avoid creating and maintaining hand-written local task plugin YAML files.
- Keep tab definitions with the view config so they move with a config export/import.
- Add a settings/overview tab pair where each is a separate view.
- Convert an existing menu-tab view into a proper local task without code.
- Provide contextual sub-navigation for a section landing page built as a view.
- Reuse core's `ViewsLocalTask` derivative behavior while adding parent/base-route control.
- Ensure the module's local task overrides win by running its alter hook last.
