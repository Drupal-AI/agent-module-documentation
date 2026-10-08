<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Workbench Tabs (workbench_tabs) — agent index

Relocates Drupal's **local task tabs** (Edit / View / Revisions / Delete) and **status messages**
out of the theme and into a fixed bar at the top of every page. Custom themes then don't have to
place or style these administrative elements, long messages stop breaking layouts, and the tabs an
editor uses stay in one predictable spot. Version **8.x-1.8**, core `^9 || ^10 || ^11`.
**Standalone** despite the `Workbench` package name — no dependency on the Workbench module or the
core Toolbar module.

## Mechanism (read the source, this is accurate)

- **`hook_page_top()`** (`workbench_tabs.module`) adds a `#theme => 'workbench_tabs'` element to
  every page *when* `workbench_tabs.info` service `applyWorkbenchTabs()` returns TRUE.
- **`WorkbenchTabsInfo::applyWorkbenchTabs()`** (`src/WorkbenchTabsInfo.php`): TRUE if the
  `enable_for_admin_theme` config flag is set, **or** if the current route is *not* using the admin
  theme. So by **default (flag off) the bar shows only on non-admin/front-end-theme pages**; the
  "Everywhere" setting turns it on for admin pages too. `hook_update_8001` sets the flag TRUE on
  upgrade to keep the old always-on behaviour.
- The whole element carries **`#access => hasPermission('use workbench_tabs')`**. Users without the
  permission see status messages in their theme's normal position. `hook_install()` grants
  `use workbench_tabs` to the **authenticated** role.
- **`workbench_tabs_status_messages`** render element (`src/Element/StatusMessages.php`): reads
  `messenger->all()` then `deleteAll()`, so each message renders **once**, here instead of the
  theme. Re-themes as core `status_messages` with status/error/warning headings.
- **`workbench_tabs_local_tasks`** render element (`src/Element/LocalTasks.php`): asks
  `plugin.manager.menu.local_task` for primary + secondary tasks of the current route (so tasks are
  **access-filtered by the core manager**). Includes a regex workaround for `entity.*.canonical`
  routes taken over by Page Manager.
- **`hook_block_build_alter()`**: when the bar is active, sets `#access => FALSE` on the core
  `local_tasks_block` so tabs don't appear twice.
- **`js/workbench_tabs_trigger.js`**: Show/Hide-messages toggle + auto-collapse the message drawer
  once the user scrolls past it.
- Templates override `menu_local_task(s)`; `css/workbench-tabs.css` styles the bar.

## Configuration

- Route **`workbench_tabs.settings`** → `/admin/config/content/workbench-tabs`, gated by
  **`administer site configuration`** (`src/Form/SettingsForm.php`). Single radios control:
  "Only on non-admin themes" (0) vs "Everywhere" (1), stored as `enable_for_admin_theme`.
- Permission **`use workbench_tabs`** controls who gets the relocated tabs/messages.
- Config object `workbench_tabs.settings` (schema in `config/schema/`), default
  `enable_for_admin_theme: false`.

## When to reach for it

Multi-theme editorial sites where local tasks / messages land in different places (or go missing) as
users cross between front-end and admin themes; custom themes that would rather not own the tab and
message regions. Not needed if a single theme already renders tabs/messages acceptably.

No submodules, no Drush commands, no plugin types provided beyond the two render elements above.
