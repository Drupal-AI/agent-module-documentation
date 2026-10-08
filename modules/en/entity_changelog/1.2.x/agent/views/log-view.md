<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The changelog view, access and permission

## Permission

`entity_changelog.permissions.yml` declares one permission: **`access entity changelog`**
(title "Access Entity Changelog", `restrict access: true`). This is the only gate for reading the log.

## Access control handler

`Drupal\entity_changelog\EntityChangelogEntryAccessControlHandler` (extends core
`EntityAccessControlHandler`). `checkAccess()` returns `AccessResult::forbiddenIf(!$account->hasPermission('access entity changelog'))`
for every operation — so all access to an `entity_changelog_entry` hinges on that single permission.

## The Views page

Default config `config/install/views.view.entity_changelog.yml` (view id `entity_changelog`, base table
`entity_changelog_entry`):

- **Page display** `page_1`: path **`admin/entity_changelog`**, placed on the `admin` menu (type `normal`,
  parent `system.admin_reports`) — i.e. under Administration → Reports, titled "Entity Changelog".
- **Access**: `type: perm`, `perm: access entity changelog` (matches the entity access handler).
- **Style**: `table`; **pager**: `mini`, 50 items per page. Default sort: `id` DESC (newest first);
  `timestamp` column is click-sortable.
- **Displayed fields** (all from the base table): `timestamp` (custom format `Y-m-d H:i:s`), `user_id`,
  `username`, `operation`, `request_path`, `entity_id`, `entity_title`, `entity_type`. Values render
  through standard Views field handlers (string/number/timestamp), which escape output.
- **Filters**: a non-exposed `status = 1` filter, plus exposed filters for `user_id` (numeric),
  `username` (grouped select), `entity_title` (contains), `entity_type` (grouped select), `entity_id`
  (numeric), `request_path` (contains), `operation` (grouped select: Insert/Update/Delete), and
  `timestamp` (date, with operator choice incl. between/not between).

## Grouped-filter population

`entity_changelog_views_pre_build()` (in `.module`) runs only for view id `entity_changelog`. It calls
`EntityChangelogLogger::getLoggedEntityTypes()` and `getLoggedUsernames()` and injects the results into
`$view->filter['entity_type']` and `$view->filter['username']` `group_info.group_items`, so those grouped
exposed filters offer exactly the entity types / usernames actually present in the log.

## Notes

- The timestamp exposed filter renders as a plain text field in core; the project README suggests a date
  widget module if a picker is wanted.
- There are no per-entry routes (no canonical/edit/delete links); the log is read-only through this view.
