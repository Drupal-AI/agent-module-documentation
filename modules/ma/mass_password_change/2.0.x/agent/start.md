<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mass Password Change (mass_password_change) — agent index

Bulk user-account operations for Drupal 10.4+/11.1+. The module adds two **core Action
plugins** (type `user`) that show up in the bulk-operations dropdown on `/admin/people`
and in Views Bulk Operations (VBO). Version **2.0.0**. Depends on core `user`; `views`
is required for the VBO/people-listing integration. No settings page, no own permissions.

## The two actions (they do different things)

1. **Password reset** — action id `mass_password_reset_action`, confirm form
   `MassPasswordResetConfirm` at `/admin/people/mass_password_change/reset_confirm`.
   For each selected account it calls `_user_mail_notify('password_reset', $account)` —
   i.e. it sends Drupal's standard **one-time login link email**. It does **not** change
   or invalidate the stored password. No effect until the user clicks the link; no effect
   at all if site mail does not deliver.

2. **Change password** — action id `mass_password_change_action`, confirm form
   `MassPasswordChangeConfirm` at `/admin/people/mass_password_change/change_confirm`.
   The confirm form has a single `password_confirm` field; on submit it writes that **one**
   password onto **every** selected account (`$account->setPassword($password); $account->save();`).
   All selected users end up sharing the same known password until they change it.

## Access & guards

- Both routes require the core **`administer users`** permission (`restrict access: TRUE`).
- Action `access()` excludes **user 1** and the **acting/current user** from selection;
  the reset action additionally excludes **blocked** accounts.
- Selection flows through `PrivateTempStore` between the action and the confirm form. The
  confirm forms are standard Drupal forms (CSRF token present).

## Mechanism notes for agents

- **No batch API.** The confirm forms loop over the accounts synchronously in `submitForm`,
  so a very large selection can exceed PHP time/memory limits. Chunk large jobs.
- **"Change password" is not randomization.** It sets an operator-supplied shared password;
  it is not per-user and not a random secret. Prefer "Password reset" for real lockout/rotation.
- **"Password reset" changes nothing by itself.** It only queues the reset email. Confirm mail
  delivery before relying on it during an incident.
- The confirm form re-reads the target uids from hidden form fields (see the note in
  `agent/forms/actions.md`).

See `agent/forms/actions.md` for the plugin/form wiring. `data.json` for metadata,
`usage.md` for scenarios.
