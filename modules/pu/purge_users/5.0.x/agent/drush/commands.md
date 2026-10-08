# Purge Users Drush commands

Source: `src/Commands/PurgeUsersDrushCommands.php` (registered via `drush.services.yml`, injected with
`purge_users.policy_service`).

| Command | Aliases | Options | Effect |
|---|---|---|---|
| `purge-users:purge` | `pu:purge`, `purge-users` | `--dry-run` | Evaluates all configured policies and queues matching users for purge. Prints `<N> users queued for purge.` With `--dry-run`, simulates selection without deleting/cancelling. |
| `purge-users:notify` | `pu:notify`, `purge-notify` | — | Queues pre-deletion notification emails for users due one. Prints `<N> users queued for notification.` |

```bash
# Preview which users a purge would select (no changes)
ddev drush purge-users:purge --dry-run

# Queue matching users for purge (processed by the queue worker / cron queue runner)
ddev drush purge-users:purge

# Queue pre-deletion warning emails
ddev drush purge-users:notify
```

Notes:
- Both commands delegate to `PurgeUsersPolicyService` (`purgeAllUsers(FALSE, $dry_run)` /
  `notifyAllUsers()`), i.e. they operate on the **policy** config entities, and enqueue work rather than
  deleting inline — the `purge_users` / `notification_users` queues are then drained by their queue
  workers (e.g. on cron or `drush queue:run`).
- The global-settings age rules are enqueued by `hook_cron()` when `purge_on_cron` is enabled; the Drush
  `purge` command is the manual/scriptable equivalent for policies.
