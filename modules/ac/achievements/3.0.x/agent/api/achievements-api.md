<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Achievements PHP API (award, query, storage)

All grant/query logic lives as **procedural functions in `achievements.module`** (no service). There is
**no HTTP route that awards an achievement** — you call these from your own module's hooks
(`hook_entity_insert`, `hook_node_insert`, event subscribers, etc.). See `achievements.api.php` for worked
examples (comment-count milestones, "posted on a Monday", etc.).

## Awarding & removing

- `achievements_unlocked($achievement_id, $uid = NULL, $timestamp = NULL)` — records an unlock. Steps:
  1. `list($uid, $access) = achievements_user_is_achiever($uid)`; returns `FALSE` if `$access` is false.
  2. Loads the `achievement_entity`; logs an error and returns `FALSE` if the id is unknown.
  3. If not already unlocked, opens a DB transaction: `SELECT max(rank)` for the achievement,
     `INSERT` into `achievement_unlocks` (rank = last+1, `seen = 0`), and `MERGE` into
     `achievement_totals` incrementing `points` (by the achievement's points) and `unlocks` by 1.
  4. Updates the `achievements_unlocked_already` static cache and invokes `hook_achievements_unlocked`.
  - **Idempotent** — a second call for an already-unlocked (achievement, user) is a no-op.
- `achievements_locked($achievement_id, $uid = NULL)` — relocks/removes an unlock: deletes the
  `achievement_unlocks` row, subtracts points and decrements `unlocks` in `achievement_totals` (or
  deletes the totals row if it was their only unlock), and sets the previous unlock as "latest".
  Returns `TRUE` if it removed anything. Invoked indirectly by `achievements_reset()`.
- `achievements_reset($achievement_id, $uid = NULL)` — relocks (if unlocked) **and** deletes the
  achievement's storage via `achievements_storage_del()`, then invokes `hook_achievements_locked`.

## Querying unlocks / totals

- `achievements_unlocked_already($achievement_id = NULL, $uid = NULL)` — returns one unlock array
  (`achievement_id`, `rank`, `timestamp`), all of the user's unlocks (keyed by achievement id), or `NULL`.
  Gated by `achievements_user_is_achiever()`; results are statically cached per uid (one `SELECT ... WHERE
  uid = :uid` on `achievement_unlocks`).
- `achievements_totals_user($uid = NULL)` — returns the user's `achievement_totals` row joined to
  `users_field_data` (name) with a computed overall `rank`. Rank = count of users with more points +
  count with equal points but an earlier `timestamp` + 1. Query is tagged `achievement_totals_user`.
- `achievements_load($id)` / `achievements_load_all($reset = FALSE)` — load `achievement_entity`
  config entities via the entity type manager (statically cached).

## Per-user storage (for time/count-based achievements)

- `achievements_storage_get($achievement_id, $uid = NULL)` — returns `unserialize()` of the `data` blob
  from `achievement_storage` for that (achievement, user), or `FALSE` if the user can't earn.
- `achievements_storage_set($achievement_id, $data, $uid = NULL)` — `MERGE`s `serialize($data)` into
  `achievement_storage`.
- `achievements_storage_del($achievement_id, $uid = NULL)` — deletes the storage row (uses the
  achievement's `storage` key if set, else its id).
- The blob is written only by your own achievement code through `_set()` (server-side `serialize()`);
  it is never populated directly from a request.

## Access gate — `achievements_user_is_achiever($uid = NULL)`

Central helper deciding whether a user may earn achievements. Defaults `$uid` to the current user.
Checks `hasPermission('earn achievements')` on that account (loads the user if it is not the current one),
then lets modules override via `hook_achievements_access_earn($uid)` — a hook returning `TRUE` forces
access, `FALSE` denies it (hook results take precedence over the permission). Returns `[$uid, $access]`.
This is the permission check behind every award, query and storage function above — it checks the
**subject** user's own earn permission, not an acting administrator's.

## Notifications & cleanup (hooks in `achievements.module`)

- `achievements_page_bottom()` — on each page load for an achiever, selects unseen unlocks
  (`seen = 0`) for the current user, renders `achievement_notification` (attaching the
  `achievements/achievements` library), then flags them `seen = 1`.
- `achievements_user_delete()` / `achievements_user_cancel()` — delete the user's rows from
  `achievement_totals`, `achievement_unlocks`, and `achievement_storage`.
