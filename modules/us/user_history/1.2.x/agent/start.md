<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User history (user_history) — agent index

Records every change to a `user` account (insert / update / delete) as an immutable `user_history`
content entity — the audit trail core does not keep. Recording happens in `hook_user_insert/update/delete`
in `user_history.module`; there is no service. Each record snapshots the account's base properties (and
any opted-in user fields) plus who made the change and a human diff summary.

- Depends on core `user` only. Core: `^8.8 || ^9 || ^10 || ^11`. No composer requirements, no submodules.
- Configure route: `user_history.settings` → `/admin/structure/user_history/settings`.
- Defines permissions; **no** drush; **no** plugin types; provides config schema, two Views, one entity.
- After enabling you must run the **Initialise** batch (`/user_history/initialise`) to baseline existing
  accounts — `hook_requirements`/`hook_help` nag until it runs.

## Solution docs

- **Change what is tracked / retention / archive settings** → [configure/settings.md](configure/settings.md)
- **Who can see / administer the trail** → [permissions/permissions.md](permissions/permissions.md)
- **How records are created (the user hooks, diff, cron pruning)** → [hooks/recording.md](hooks/recording.md)
- **The entity, its fields/table, querying, and the batch initialise/update/archive/restore forms** → [api/entity.md](api/entity.md)
- **The profile History tab and the admin listing views** → [views/views.md](views/views.md)

## Key facts

- Config object: `user_history.settings` (keys `no_change.ignore|delete|batch`, `base_fields.*`,
  `attached_fields.*`, `archive.directory|filename|max_cardinality`).
- Entity: `user_history`, base table `user_history`, single bundle, immutable
  (update/delete/create forbidden by `UserHistoryAccessControlHandler`).
- Permissions: `administer user_history entities` (restrict access), `view user_history entities`,
  and inert `add`/`edit`/`delete user_history entities`.
- Routes: `user_history.settings`; `user_history.batch_install_form` `/user_history/initialise`;
  `user_history.batch_update_form` `/user_history/update`; `user_history.batch_archive_form`
  `/user_history/archive`; `user_history.batch_restore_form` `/user_history/restore`;
  `user_history.history_tab` `/user/{user}/history`; `entity.user_history.canonical`
  `/user_history/{user_history}`.
- Views: `user_history` (History tab, path `user/%/history`, perm `view user_history entities`),
  `user_history_list` (path `user_history/list`, perm `administer user_history entities`).
- Service: `user_history_config_events_subscriber` (`ConfigEventsSubscriber`) flags when a tracked-field
  config change needs the Update batch.
- State flags: `user_history.initialise_required`, `user_history.base_fields_update_required`,
  `user_history.attached_fields_update_required`, `user_history.install_date`.
