<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views & the profile History tab

Two views ship in `config/install/`. Views data comes from `UserHistoryViewsData` (default
`EntityViewsData`, no custom joins).

## `user_history` — the "History" tab

- Page display path: `user/%/history` (the `%` is a uid). A local task (`user_history.links.task.yml`,
  `user_history.history_tab`, base route `entity.user.canonical`) adds a **History** tab to every user
  profile pointing at `/user/{user}/history`.
- Access: `perm` → `view user_history entities`.
- Contextual filter: argument on `user_id`, `default_argument_type: user` (takes the uid from the URL),
  so the tab lists only the profiled account's records.
- Row plugin renders each record with the **`tab` view mode**
  (`core.entity_view_display.user_history.user_history.tab`), which shows label, created, action,
  modified_by, user_name, user_mail, user_timezone, user_status, user_roles, user_login. Mini pager,
  10/page, exposed sort.

`user_history.routing.yml` also declares a `user_history.history_tab` route for the same path; the
rendered content is the view.

## `user_history_list` — admin listing

- Page display path: `user_history/list`.
- Access: `perm` → `administer user_history entities` (admin-only).
- No contextual filter — lists all records across all accounts, with an exposed filter/relationship on
  `user_id` and a link to `/user/{{ user_id }}`.

This shares the path `/user_history/list` with the entity `collection` route and the
`UserHistoryListBuilder` (header: Label, User name, User mail, Modified by); both are gated by
`administer user_history entities`.

## View modes

| View mode | Config | Used by |
|---|---|---|
| `default` | `core.entity_view_display.user_history.user_history.default` | canonical record page `/user_history/{user_history}` — renders every snapshot field |
| `tab` | `core.entity_view_display.user_history.user_history.tab` | the profile History tab view (subset of fields) |

## Re-use

To build a custom report, add a View on base table **User history** (`user_history`) and filter/sort on
`user_id`, `action`, `created`, `modified_by`, or `difference`. Set the row's view mode to `default` or
`tab`, or pick individual fields.
