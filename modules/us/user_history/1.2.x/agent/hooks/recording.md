<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Recording mechanism (hooks it implements)

All recording lives in `user_history.module`. There is no service — the module reacts to core
`user` entity hooks and writes one `user_history` entity per event.

| Hook | Action value | Behaviour |
|---|---|---|
| `hook_user_insert` | `Insert` | Snapshot the new account; `user_deleted = FALSE`; `modified_by = current user`. |
| `hook_user_update` | `Update` | Snapshot the account, load the most recent prior record for that uid, compute the diff (`user_history_diff_user_history()`), store it in the `difference` field. If the diff is empty **and** `no_change.ignore` is `true`, no record is written. |
| `hook_user_delete` | `Delete` | Snapshot the account; `user_deleted = TRUE`; `difference = "User account has been deleted!"`. |
| `hook_cron` | — | If `no_change.delete` is set, delete `action = update` records with an empty `difference` older than that PHP period, capped at `no_change.batch` per run. |

Support hooks: `hook_help` and `hook_requirements` surface a warning + link to the initialise
(`/user_history/initialise`) or update (`/user_history/update`) batch form while the
`user_history.initialise_required` / `*_update_required` state flags are set; `hook_theme` registers
the `user_history` template; `hook_install` seeds all `base_fields.*` to `TRUE`, sets
`initialise_required = TRUE`, and grants `add user_history entities` to the authenticated role;
`hook_uninstall` clears the module's `state` keys.

## What a record captures

`user_history_create_user_history(UserInterface $account)` copies these account values into the new
entity (fields listed in `api/entity.md`): uid, name, **hashed password**, mail, timezone, status,
roles (`; `-joined), created, changed, access, login, init (initial mail), langcode,
preferred_langcode, preferred_admin_langcode — plus any tracked `attached_fields` copied from the
user entity.

## Diff logic

`user_history_diff_user_history($recent, $current)` returns a comma-joined list of the human labels of
the properties/fields that changed (e.g. `User mail, User roles`). Notes:
- `user_changed`, `user_access`, `user_login` are intentionally excluded from the diff (they change on
  every login/edit and would create noise).
- If the deleted flag differs it short-circuits to `User account has been deleted!`.
- Attached fields are compared item-by-item after casting scalars to strings
  (`_user_history_cast_scalar_to_string()`) to avoid false positives.
- The `difference` field is truncated to 255 chars in `UserHistory::setDifference()`.

## Recording is unconditional per base field

There is no per-role "skip tracking" and no UI to disable base-field tracking — every `user`
insert/update/delete produces a snapshot of all base properties (subject only to the `no_change`
skip on updates). `attached_fields` are the only opt-in/opt-out toggles.
