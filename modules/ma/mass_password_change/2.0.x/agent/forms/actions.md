<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Actions & confirm forms

Two core Action plugins (`type: user`), each paired with a `ConfirmFormBase` via the
plugin's `confirm_form_route_name`. Selection is carried in `PrivateTempStore`
(`tempstore.private`, collection `mass_password_change`).

## Files

- `src/Plugin/Action/MassPasswordReset.php` — id `mass_password_reset_action`,
  `confirm_form_route_name = mass_password_change.password_reset_confirm`.
- `src/Plugin/Action/MassPasswordChange.php` — id `mass_password_change_action`,
  `confirm_form_route_name = mass_password_change.password_change_confirm`.
- `src/Form/MassPasswordResetConfirm.php` / `src/Form/MassPasswordChangeConfirm.php`.
- `mass_password_change.routing.yml` — both routes require `_permission: 'administer users'`.
- `config/install/system.action.*.yml` — pre-created action config entities so the actions
  appear in the `/admin/people` bulk dropdown out of the box.

## Flow

1. Admin ticks accounts on `/admin/people` (or a VBO View) and picks an action.
2. `executeMultiple($accounts)` stores the selected user objects in tempstore under the
   key `password_reset` or `password_change`, then core redirects to the confirm route.
3. The confirm form reads that tempstore key, lists the account names, and renders hidden
   `accounts[uid]` fields (`#type => hidden`, `#value => uid`, tree). The change form also
   renders a `password_confirm` field.
4. On confirm, `submitForm` deletes the tempstore entry and loops over
   `$form_state->getValue('accounts')`:
   - **reset:** `_user_mail_notify('password_reset', $account)` per uid.
   - **change:** `$account->setPassword($password); $account->save();` per uid.
   Then redirects to `entity.user.collection`.

## Action `access()` guards (selection-time only)

- Change: `($user->id() != 1) && ($user->id() != $account->id())` — excludes user 1 and the
  acting admin.
- Reset: same, plus `&& !$user->isBlocked()` — also excludes blocked accounts.

These guards run when core builds the bulk-op selection, so user 1 and the acting admin
(and, for the reset action, blocked accounts) are not offered in the dropdown. Both routes
require `administer users` (`restrict access: TRUE`) — the same permission core requires to
change any account's password through the account edit form.

## Gotchas

- No `#batch`: processing is synchronous inside `submitForm`. Large selections risk timeouts.
- `MassPasswordResetConfirm::submitForm()` deletes the wrong tempstore key
  (`'mass_password_change'` instead of `'password_reset'`); the intended `password_reset`
  entry is left behind. Functional wart, not a security issue.
- "Change password" sets one shared password across all targets — not per-user, not random.
