<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The permission-change Views report

## Route & access

The audit view is a **Views view** `roles_change_log` (`config/optional/views.view.roles_change_log.yml`),
base table `role_change_log`. Its `page_1` display serves path
**`admin/reports/permission-watchdog`** (menu title "Permission change report", parent
`system.admin_reports`).

Access is the view's `access: { type: perm, perm: 'access permission_watchdog report' }` — the
dedicated permission **`access permission_watchdog report`** (defined in
`permission_watchdog.permissions.yml`). This is separate from the settings permission
(`administer permission_watchdog configuration`). The view is read-only; there is no clear/delete
route in the module (deletion of entries is only via the Devel Generate "kill" option).

## Columns & filters

Table style, mini pager (10/page), sorted by `timestamp` desc. Columns: `timestamp`,
`uid` (entity_reference_label, linked to the user), `role` (entity_reference_label), and the
`actions` field rendered by the `permission_action_default` formatter.

Exposed filters (all string filters on the entity/field tables): `role`, `actions_permission`
(permission id), and a grouped `actions_action` filter (Added / Removed).
`PermissionWatchdogHooks::formViewsExposedFormAlter()` replaces the raw `role` text input with a
`select` of non-admin role labels (guard: only acts when `view->id() === 'roles_change_log'`).

## How entries render (formatter)

`src/Plugin/Field/FieldFormatter/PermissionActionDefaultFormatter.php`
(`@FieldFormatter id="permission_action_default"`, `field_types={"permission_action"}`).
`viewElements()`:
- Builds two `#theme => 'item_list'` groups titled "Added" and "Removed"
  (`PermissionActionItem::allowedActionValues()`).
- For each stored action item, looks up the permission's provider module via
  `user.permissions`->`getPermissions()` and `extension.list.module`->`getName()`, then adds a list
  item built with a translated string placeholder:
  `$this->t('<strong>@provider</strong>: @permission', ['@provider' => $provider_name, '@permission' => $item->permission])`.
  The `<strong>` is literal in the format string; `@provider`/`@permission` are escaped placeholders.
- Empty "Added"/"Removed" groups are unset so only non-empty groups show.

## Generating sample data (Devel)

`src/Plugin/DevelGenerate/RoleChangeDevelGenerate.php` (`@DevelGenerate id="role_change"`,
`permission = "administer devel_generate"`). Settings form takes count, actions-per-change, and a
time range; `generateElements()` creates random `role_change_log` entities against existing
users/roles/permissions. The `kill` option (`contentKill()`) deletes all existing changes first
(`getQuery()->accessCheck(FALSE)` then `delete()`), reporting the count removed. Requires the Devel
module. The user-select query is a parameterized `select('users','u')->fields(...)->range()->orderRandom()`.
