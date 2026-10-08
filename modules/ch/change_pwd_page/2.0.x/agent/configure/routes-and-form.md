<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes & form changes

No settings form (`configure: null`) and no config of its own. Behaviour is code-driven.

## Routes (`change_pwd_page.routing.yml`)

| Route | Path | Renders / does |
|---|---|---|
| `change_pwd_page.change_password` | `/user/change-password` | Controller redirects the logged-in user to their own `change_password_form`. Requirement: `_user_is_logged_in: TRUE`. Also an account-menu link. |
| `change_pwd_page.change_password_form` | `/user/{user}/change-password` | `ChangePasswordForm` (form id `change_pwd_form`). Requirement: `_entity_access: user.update`; `{user}` is `\d+`. Also a local task tab "Change Password" on the user profile. |
| `change_pwd_page.reset` | `/user/reset/{uid}/{timestamp}/{hash}/new/login` | Custom one-time-login controller (`resetPass`). |

The module's `RouteSubscriber::alterRoutes()` also **rewrites core's `user.reset` path** to
`/user/reset/{uid}/{timestamp}/{hash}/new`.

## Changes to the user edit form (`hook_form_alter` on `user_form`)

- Hides the new-password widget: `$form['account']['pass']['#access'] = FALSE;`
- Re-labels the `current_pass` description to point at the reset-password link.
- If Password Policy is enabled, removes its profile-form validate handler from `user_form` (its validation
  is moved onto the separate `change_pwd_form` instead).

## The separate form (`change_pwd_form`)

- Shows `pass` (password_confirm, required) and, for the acting user editing their own account,
  `current_pass` (required) — **unless** the user arrived via a one-time login token
  (`pass-reset-token` query + matching `$_SESSION` key), in which case current password is not required.
- `validateForm()` checks the current password with the `password` (hasher) service; `submitForm()` sets
  and saves the new password.

There is nothing to configure via drush for this module itself; to change the *Password Policy* route
integration see [api/integration.md](../api/integration.md).
