# Purge Users — agent index

Deletes/cancels user accounts matching age- or condition-based criteria, via a global settings form or
`purge_users_policy` config entities. Runs on cron (opt-in), via Drush, or a UI confirmation form.
Depends on core `user`. Provides permissions, config schema, Drush, and condition plugins. **All
destructive actions are behind `restrict access: true` perms or `administer site configuration`, and
every default ships disabled.**

- **Global settings form keys, cancel methods, notifications, the cron trigger** →
  [configure/settings.md](configure/settings.md)
- **Policy config entities + the condition plugins that compose them** →
  [plugins/conditions.md](plugins/conditions.md)
- **Drush commands (`purge-users:purge --dry-run`, `purge-users:notify`)** →
  [drush/commands.md](drush/commands.md)
- **`hook_purge_*_user_ids_alter()` hooks** → [hooks/alter.md](hooks/alter.md)

Key facts:
- Config object `purge_users.settings` (schema present). Config entity `purge_users_policy`
  (`config_prefix: purge_users_policy`).
- Trigger: `hook_cron()` enqueues only when `purge_on_cron` == 1 (default **false**); also runs
  `purgeAllUsers()`/`notifyAllUsers()` for policies. Queues: `purge_users`, `notification_users`
  (processed by queue workers). Deletion uses core `user_cancel` methods.
- Permissions: `access purge setting page`, `access purge confirmation form` (both
  `restrict access: true`); policy CRUD requires `administer site configuration`.
- Routes under `/admin/config/people/purge-users` (+ `/policies`, `/confirm`).
