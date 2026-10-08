<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cron lifecycle — blocking, warnings, tokens, event, audit

All engine logic is `deactivate_users_cron()` in `deactivate_users.module`. It returns immediately
unless `deactivate_users.settings:enabled` is 1. Times use `\Drupal::time()->getRequestTime()` as
"now". Config days are multiplied by 86400.

## Step 0 — minimum warning gate

State `deactivate_users.first_sent_timestamp` (default = now on first run) anchors a startup delay:
blocking (step 1) runs only when `now >= first_sent_timestamp + minimum_warning_time_days*86400`.
This lets a freshly enabled module warn live users before it starts blocking. Warnings (step 2)
always run.

## Step 1 — block expired users

Two entity queries (both `status = 1`, `changed < now - timeout.changed_record`, `accessCheck()`):

- Inactive: `access < now - (inactive+grace)` and `access > 0` (has logged in).
- Never logged in: `created < now - (inactive+grace)` and `access = 0`.

For each loaded user (skipping any already `isBlocked()` — the query still returns some): if
`deactivated_email.enabled`, send mail key `deactivate_user`; then `$user->block(); $user->save();`
log a `notice` on the `deactivate_users` channel; and dispatch **`UserDeactivatedEvent`**
(`src/Event/UserDeactivatedEvent.php`, event name `deactivate_users_user_deactivated`, public
`->account`). Subscribe to it to run custom offboarding.

## Step 2 — advance warning emails

`notify_email.days` is split/trimmed/`array_unique`d into thresholds. For each `day`, offset =
`inactive*86400 - day*86400`; it selects `status = 1` users whose `access` fell below `now - offset`
since the last run for that threshold (`access >= last_sent - offset`, `access > 0`), de-duplicated
across thresholds in one run via `$sent_uids`. If `deactivated_email.enabled`, sends mail key
`notify_user`; failures log an `error`, successes log a `notice` when `log_notifications` is on.
Per-threshold last-run times persist in state `deactivate_users.last_emails_sent_timestamps`.
(Known `@todo`s in source: a user can receive multiple threshold emails across runs; no per-user
last-notified field.)

## hook_mail — `deactivate_users_mail()`

Keys `notify_user` → `notify_email.*`, `deactivate_user` → `deactivated_email.*`,
`unblock_email` → `unblock_email.*`. Loads the user by `params['uid']`, sets config-override language
to the user's preferred langcode, and runs subject/body through `\Drupal::token()->replace()` with
`callback => 'user_mail_tokens'`. From/Sender headers use the config `from_address` or fall back to
`system.site` mail.

## Tokens — `hook_token_info` / `hook_tokens`

User tokens: `[user:expire-timeout]` / `[user:expire-timeout:days]` = integer days left before
blocking, computed from `max(lastAccess, created) + inactive*86400`, floored to the minimum-warning
timestamp, never below 0; `[user:unblock-link]` = absolute signed unblock URL via
`deactivate_users_generate_unblock_link()` (see `unblock/self-unblock.md`).

## Audit — `hook_user_presave()` + `AccountStatusRecord`

Whenever an existing user's blocked state changes (`$user->original->isBlocked() != $user->isBlocked()`)
a row is written to content entity **`account_status_record`** (`src/Entity/AccountStatusRecord.php`,
base table `account_status_record`): `uid`, `action` (`block`/`active`), `method`
(`by system` when current user is anonymous/uid 0, else `by user`), `by_uid` (acting user), a plain
`description`, and `date` (created field). `getMethod()` returns the method value. The entity has no
routes, views data, UI, or access handler — query it directly (e.g. `entityTypeManager` /
`entityQuery('account_status_record')`) for reporting.
