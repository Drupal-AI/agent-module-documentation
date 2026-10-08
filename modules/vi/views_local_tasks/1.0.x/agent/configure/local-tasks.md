<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — views as local tasks

No admin page. Everything is set on a **Views Page display → Menu** settings dialog. Requires the
display's **Menu** setting to be **Tab** (`type = tab`); the extra fields only appear when the **Menu UI**
module is enabled.

## Extra Menu options (added by `PageWithLocalTasks::buildOptionsForm`)
| Option key | Widget | Meaning |
|---|---|---|
| `as_local_task` | checkbox "Local task only" | If checked (and ≥2 local tasks exist for the parent), the normal menu item is removed and the view is shown only as a local task. |
| `local_task_link_title` | textfield | Title of the extra local task. **Leave empty to NOT create a local task.** |
| `local_task_parent` | select | Parent for the local task: any applicable view page (`views_view:view.<id>.<display>`) or `_custom`. |
| `local_task_custom_parent_route` | textfield | Used only when `local_task_parent = _custom`: type a route id (e.g. `system.admin_content`, `entity.media.collection`, `comment.admin`, or a route from a module's `links.task.yml`). |
| `local_task_weight` | textfield (int, default 0) | Weight/ordering of the tab among siblings. |

These are stored on the view's `display.<id>.display_options.menu` mapping — schema keys added by
`views_local_tasks_config_schema_info_alter` onto `views.display.page`
(`as_local_task` boolean, `local_task_link_title` text, `local_task_parent` string, `local_task_weight`
integer; `local_task_custom_parent_route` is stored alongside them).

## Runtime resolution (`CustomViewsLocalTask::alterLocalTasks`)
Runs in `hook_local_tasks_alter` (forced last via `hook_module_implements_alter`). For each menu-tab view:
1. Derives the **parent route** from the display path (drops the last path segment, looks up the route by
   pattern) and sets `views_view:<plugin_id>['base_route']`.
2. If `local_task_link_title` is set, clones the tab into `views_view_local_task:<plugin_id>` with:
   - `title` = `local_task_link_title`
   - `parent_id` = the chosen `local_task_parent`, or `local_task_custom_parent_route` when `_custom`
   - `weight` = `local_task_weight`
3. If `as_local_task` is set, unsets the plain `views_view:<plugin_id>` menu entry (local-task-only).
4. Views that override an existing route are skipped (their local task is removed).

## Gotchas
- If Menu UI is disabled, the extra fields are not shown and no local task options are stored.
- Every local task **needs a parent**; with `_custom` you must fill the custom route id or no parent is set.
- Rebuild caches (`drush cr`) after changing menu/tab settings so local task definitions refresh.
