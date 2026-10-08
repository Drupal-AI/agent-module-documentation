<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Recently Read — tracked types, pruning, and display

## 1. Choose which entity types are tracked

`recently_read_type` is a **config entity** (one per tracked entity type). Manage them at
`/admin/structure/recently-read` (route `entity.recently_read_type.collection` — the module's
`configure` route). Each entry has:

- `id` / `label` — the entity type id it applies to (e.g. `node`).
- `types` — a bundle list. When set, only those bundles are recorded; when the value is falsy
  the whole entity type is recorded. (In `hook_entity_view` the check is
  `in_array($entity->bundle(), $allowedTypes)`.)

Ships on install with one entry for `node`
(`config/install/recently_read.recently_read_type.node.yml`). Add more by creating a
`recently_read_type` for the target entity type (via the UI "Add" button or a
`recently_read.recently_read_type.<id>.yml` config file). Only entity types with a matching
`recently_read_type` are ever recorded.

Recording is automatic: on any **full** view-mode render of a tracked entity,
`RecentlyReadService::insertEntity()` inserts or refreshes a row. Previews and non-full view
modes are ignored.

## 2. Pruning / retention settings

Form at `/admin/config/system/recently-read/config` (route `recently_read.settings_basic`,
permission `access configuration pages`), config object `recently_read.configuration`:

| Key | Values | Effect |
|---|---|---|
| `delete_config` | `never` / `time` / `count` | pruning strategy |
| `delete_time` | strtotime string (e.g. `-1 month`) | with `time`: on **cron**, delete records `created <=` that time |
| `count` | integer | with `count`: on **insert**, keep only the newest N records per user |

`time` pruning runs in `recently_read_cron()`; `count` pruning runs inline in `insertEntity()`
after each new record.

## 3. Display the history (Views)

Install ships a view `recently_read_content` (`views.view.recently_read_content`) that lists
the current user's recently read nodes. To show it, place its **block** at
`/admin/structure/block`.

To build your own list: create a view over the entity you track, add the **Recently read**
relationship (`recently_read_relationship`) with *Require this relationship* checked, and set
its `user_scope` to the current user; optionally add the boolean filter
`recently_read_user_filter` to limit rows to the acting user. Sort by the relationship's
`created` descending for most-recent-first.
