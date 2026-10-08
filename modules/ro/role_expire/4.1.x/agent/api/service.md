# Role Expire — programmatic API

## The service

`role_expire.api` (`Drupal\role_expire\RoleExpireApiService`), fetched with
`\Drupal::service('role_expire.api')`. Key methods:

| Method | Purpose |
|---|---|
| `getUserRoleExpiryTime(int $uid, string $rid): mixed` | Expiry timestamp for a user+role, or `''`. |
| `getAllUserRecords(int $uid): array` | Map rid → expiry_timestamp for a user. |
| `writeRecord(int $uid, string $rid, int $expiry_timestamp, bool $delete_session = FALSE)` | Insert/replace a user+role expiry (timestamp is a Unix int, e.g. `strtotime('+3 months')`). |
| `deleteRecord(int $uid, string $rid, bool $delete_session = TRUE)` | Remove one user+role expiry. |
| `deleteUserRecords(int $uid, ...)` / `deleteRoleRecords(string $rid)` | Bulk delete by user or by role. |
| `getDefaultDuration(string $rid): string` | The role's default duration string (`''` if none). |
| `setDefaultDuration(string $rid, string $duration)` / `deleteDefaultDuration(string $rid)` | Manage the per-role default duration in `role_expire.config`. |
| `getExpired(?int $time = NULL): array` | Rows (rid, uid, expiry_timestamp) at/older than `$time` (default: now). |
| `getRolesAfterExpiration(): ?array` | Map rid → replacement rid from config. |
| `getEnabledExpirationRoles(): array` | rids that participate in expiration. |
| `processDefaultRoleDurationForUser(string $rid, int $uid)` | Apply a role's default duration to a user if they have no expiry yet. |

Example — expire a user's `editor` role in 3 months:

```php
\Drupal::service('role_expire.api')->writeRecord(
  $uid, 'editor', strtotime('+3 months')
);
```

Read it back: `getUserRoleExpiryTime($uid, 'editor')` returns the timestamp.

## Storage

Table `role_expire` (defined in `role_expire.install`): columns `uid` (int), `rid`
(varchar 128), `expiry_timestamp` (int), primary key (`uid`, `rid`). This is the source of truth
for per-user expiry; default durations and the replacement-role map live in `role_expire.config`.

## Cron expiry

`role_expire_cron()` calls `getExpired()`; for each expired row it deletes the record, removes the
role from the user (and, if `role_expire_default_roles` maps it, adds the replacement role and
applies that role's default duration), saves the user, and dispatches a `RoleExpiresEvent`.

## The RoleExpiresEvent

`Drupal\role_expire\Event\RoleExpiresEvent` (constant `EVENT_NAME =
'role_expire_event_role_expires'`) is dispatched whenever a role is removed by expiry. It exposes
`->account` (the `UserInterface`) and `->ridBefore` (the expired role id). Subscribe with a normal
event subscriber, or use the `role_expire_rules` submodule to react via Rules.

## Also provided

- **Views**: field plugins `RoleExpireDate`, `RoleExpireExpiryData`, `RoleExpireRid`
  (`src/Plugin/views/field/`) expose expiry data to Views, plus `role_expire.views.inc`.
- **Migrate**: a `RoleExpire` migrate source plugin for importing D7 `role_expire` data.
