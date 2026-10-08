<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Change Mail Page (change_mail_page) — agent index

A dedicated, password-verified **email-change page** for Drupal users, separate from the full
account-edit form. Package **User Management**. Core `^10 || ^11`. License GPL-2.0-or-later.
Version 1.0.2. **No dependencies** (core only); optional soft integrations with `check_dns` and
`change_pwd_page`.

- **Routes, the form, the alter hook, access model, and how to operate it** →
  [forms/change-mail.md](forms/change-mail.md)

## What it actually is

- Two routes (`change_mail_page.routing.yml`):
  - `change_mail_page.change_mail` → `/user/change-mail`, controller
    `ChangeMailPageController::changeMail()`, requirement `_user_is_logged_in: TRUE`. Just
    redirects to the current user's form.
  - `change_mail_page.change_mail_form` → `/user/{user}/change-mail`, `_form: ChangeMailForm`,
    requirement `_entity_access: user.update`, `user: \d+`, `_admin_route: TRUE`.
- One form: `src/Form/ChangeMailForm.php` (`ChangeMailForm extends FormBase`, id
  `change_mail_form`) — an **email** field (defaulted to the user's current mail) and a
  **current_pass** password field, both required.
- One controller: `src/Controller/ChangeMailPageController.php`.
- One hook: `change_mail_page_form_user_form_alter()` in `change_mail_page.module` — removes the
  `mail` field from the standard user form for non-admins (and `current_pass` too when
  `change_pwd_page` is enabled); leaves it for admins and forces it required on register.
- One local task: `change_mail_page.links.task.yml` adds the "Change Email" tab under
  `entity.user.canonical`.

## No config / no plugins

- **No** `*.permissions.yml`, `*.services.yml`, `config/**`, plugins, or Drush. Nothing to
  configure — behavior is fixed. Access and validation are delegated entirely to core's user
  entity (`user.update` access + core user-entity validation constraints).
