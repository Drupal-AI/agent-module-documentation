<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works: form, route override, events, hook

## Form alter

`prlp_form_user_pass_reset_alter()` adds a `password_confirm` element `pass` ("Set New Password")
to the core `user_pass_reset` form, `#required` = the `password_required` setting.

## Route override

`RouteSubscriber` swaps the controller of the core **`user.reset.login`** route for
`Drupal\prlp\Controller\PrlpController::prlpResetPassLogin` (PrlpController extends core
`UserController`).

## `prlpResetPassLogin()` flow

1. Load the user by `uid`; deny access if missing or blocked.
2. Build a `FormState` for `UserPasswordResetForm` and **dispatch `PrlpEvents::PASSWORD_VALIDATE`**
   (`prlp.password_validate`) so listeners can add validation errors.
3. Build the reset form to collect its errors; on error, stash `pass_reset_hash` /
   `pass_reset_timeout` in the session and redirect back to `user.reset.form`.
4. Otherwise call `parent::resetPassLogin()` (the normal one-time login).
5. If that redirects to `entity.user.edit_form` (success) and a `pass` value was submitted:
   set the password, **dispatch `PrlpEvents::PASSWORD_BEFORE_SAVE`** (`prlp.password_before_save`),
   `$user->save()`, and show "Your new password has been saved."
6. Compute the redirect from `login_destination` (replacing `%user`/`%front`, ensuring a leading
   `/`), let modules alter it via `hook_prlp_login_destination_alter`, resolve it as an internal
   URL (falling back to the original then `user.page`), and redirect there.
7. An invalid/reused link throws `InvalidArgumentException` → the user is logged out with an error
   and sent to `user.pass`.

## Events (for integrators)

Both dispatched by the controller; subscribe via a normal event subscriber service:

| Constant | Event name | When | Payload |
|---|---|---|---|
| `PrlpEvents::PASSWORD_VALIDATE` | `prlp.password_validate` | before validation | `PrlpPasswordValidateEvent` → `getFormState()` (by ref), `getUser()` |
| `PrlpEvents::PASSWORD_BEFORE_SAVE` | `prlp.password_before_save` | after set, before `$user->save()` | `PrlpPasswordBeforeSaveEvent` → `getUser()` (by ref) |

Add validation errors via `$event->getFormState()->setErrorByName('pass2', …)`. This is how the
`prlp_password_policy` submodule enforces Password Policy at reset time.

## Hook

```php
/** Implements hook_prlp_login_destination_alter(). */
function mymodule_prlp_login_destination_alter(string &$login_destination): void {
  $login_destination = '/user';   // e.g. always send to the account page
}
```
Runs after token replacement; return a valid internal path (a bad value is logged and the
original/default is used instead).
