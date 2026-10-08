<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Password Reset Landing Page (PRLP) — agent index

Lets a user **set a new password directly on the one-time-login (password reset) landing page**
instead of logging in and then editing their account. Works by adding a `password_confirm` field
to the core `user_pass_reset` form and overriding the `user.reset.login` controller to save the
new password and redirect. Config UI at `/admin/config/people/accounts/prlp`.

- **Settings (`password_required`, `login_destination` + `%user`/`%front` tokens), permission** →
  [configure/settings.md](configure/settings.md)
- **How it works: route override, form alter, the two events, and `hook_prlp_login_destination_alter`** →
  [api/behavior.md](api/behavior.md)

Submodule: **prlp_password_policy** — integrates PRLP with the Password Policy module (constraints
table + validation on the reset page). Docs nested under
`modules/prlp_password_policy/2.1.x/`.

Key facts:
- Config `prlp.settings`: `password_required` (bool, default `true`), `login_destination`
  (default `/user/%user/edit`).
- Permission: `administer prlp settings` (restricted). No Drush. No plugins.
- Overrides route `user.reset.login` → `PrlpController::prlpResetPassLogin`.
- Events: `prlp.password_validate` (`PrlpEvents::PASSWORD_VALIDATE`),
  `prlp.password_before_save` (`PrlpEvents::PASSWORD_BEFORE_SAVE`).
