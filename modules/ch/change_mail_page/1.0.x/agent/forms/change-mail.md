<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Change Mail Page — routes, form, hook, access

Everything the module does. There is no configuration, no permissions file, no services file.

## Install / enable

```bash
composer require drupal/change_mail_page
drush en change_mail_page
```

No settings page (`configure` is null). After enable, a **"Change Email"** tab appears on user
profile pages and the email field disappears from the normal edit form for non-admin users.

## Routes (`change_mail_page.routing.yml`)

| Route id | Path | Handler | Access requirement |
|---|---|---|---|
| `change_mail_page.change_mail` | `/user/change-mail` | `ChangeMailPageController::changeMail()` | `_user_is_logged_in: TRUE` |
| `change_mail_page.change_mail_form` | `/user/{user}/change-mail` | `_form: ChangeMailForm` | `_entity_access: user.update` |

- The form route constrains `user: \d+`, upcasts `{user}` to a `user` entity, and sets
  `_admin_route: TRUE` (renders in the admin theme).
- `ChangeMailPageController::changeMail()` (extends `ControllerBase`) simply returns
  `$this->redirect('change_mail_page.change_mail_form', ['user' => $this->currentUser()->id()])`
  — it never accepts a target uid from the request; the uid is always the logged-in user's.

## Access model

- The form is gated by **`_entity_access: user.update`**, evaluated against the routed `{user}`
  entity. Core's `UserAccessControlHandler` grants `update` on a user only to that same user
  (own account) or to any user holding the **`administer users`** permission. A normal user
  therefore cannot open another user's `/user/{uid}/change-mail` page (403) — no IDOR on the uid.
- No custom permission is defined; access is entirely core's.

## The form (`src/Form/ChangeMailForm.php`)

- `getFormId()` → `change_mail_form`. Injected services (via `create()`): the `user.settings`
  immutable config and `module_handler`.
- `buildForm(..., UserInterface $user = NULL)` receives the routed user, stores it with
  `$form_state->set('user', $account)`, and builds:
  - `account.mail` — `#type email`, required, `#default_value` = `$account->getEmail()`,
    `autocomplete off`, and the standard core email description.
  - `account.current_pass` — `#type password`, required, `autocomplete off`.
  - `actions.submit`. `#cache.tags` set from `user.settings` config cache tags.
- `validateForm()`:
  - `$account->setEmail($mail)` and `$account->setExistingPassword($current_pass)` (both trimmed),
    then `$violations = $account->validate()` — full core **user-entity validation**. This is
    what enforces the current-password check (core's `ProtectedUserFieldConstraint` requires the
    existing password when the current user changes their own protected `mail` field), the email
    format, and email uniqueness.
  - Surfaces violations for the `mail` and `current_pass` fields via
    `$violations->getByFields(['mail', 'current_pass'])` → `setErrorByName()`.
  - If `check_dns` is enabled, calls `check_dns_user_register_validate($form, $form_state)` to
    validate the new domain's DNS.
- `submitForm()`: re-applies `setEmail()` / `setExistingPassword()` and calls `$account->save()`,
  then a "Your email has been changed." status message. (Submit only runs when validation passed,
  so the password/format/uniqueness rules gate the save.)

Because this is a `FormBase` form, Drupal's automatic form token provides CSRF protection on the
POST; the change is never made via a plain GET.

## The alter hook (`change_mail_page.module`)

`change_mail_page_form_user_form_alter(&$form, &$form_state, $form_id)`:

- On `user_register_form`: if the current user is **not** anonymous (admin creating an account),
  force `account.mail` required; then return (leaves the register form's mail field intact).
- If the current user has **`administer users`**: return unchanged — admins keep editing email on
  the standard user form.
- Otherwise (a regular user editing their own account): `unset($form['account']['mail'])` so the
  email field is removed from the main edit form. Additionally, if `change_pwd_page` is enabled,
  `unset($form['account']['current_pass'])` (that module already provides a separate password
  page, so the current-password field is no longer needed here).

## Local task (`change_mail_page.links.task.yml`)

Adds task `change_mail_page.change_mail_form` (title "Change Email") under base route
`entity.user.canonical` — i.e. a tab on the user profile page.

## Operating notes

- Self-service email change: user goes to `/user/change-mail` (or the profile "Change Email" tab),
  enters the new address + current password, submits.
- Admin changing another user's email: use the normal user edit form (the module leaves it
  available to `administer users`), or visit `/user/{uid}/change-mail` directly.
- Nothing to export/import — no config objects or schema ship with the module.
