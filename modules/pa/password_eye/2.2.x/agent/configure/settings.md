<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure which forms get the eye icon

The whole configuration is a single list of **form ids**.

## Config

- Object: `password_eye.settings`
- Key: `password_eye.form_id_password` — a **comma-separated** string of Drupal form ids.
- Default (created in `hook_install`): `user_login_form`.

For every form whose `$form_id` is in that list, `hook_form_alter()` adds the CSS class
`pwd-see` to the form and attaches the `password_eye/pwd_eye_lib` library. Forms not in the
list are untouched.

## Settings form (UI)

- Route: `password_eye.route` → `/admin/config/system/pssword_eye-settings`
  (the path segment is misspelled "pssword"). Menu link "Password Eye Settings" under
  *Configuration → System*.
- Access requirements: `_permission: 'access content'` **and** `_role: 'administrator'`.
- One textarea, "Enter the form id here." — enter one or more form ids separated by commas.
  Clearing it (empty) disables the eye everywhere.

## Set it via drush

```bash
# Add the registration form alongside the login form:
drush cset password_eye.settings password_eye.form_id_password 'user_login_form,user_register_form' -y

# Read it back:
drush cget password_eye.settings password_eye.form_id_password
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('password_eye.settings')
  ->set('password_eye.form_id_password', 'user_login_form,user_register_form')
  ->save();
```

## Front-end behaviour

The library adds `css/password_eye.css` + `js/password_eye.js` (depends on `core/jquery`).
`Drupal.behaviors.pwd` inserts a `span.shwpd` (class `eye-close`) after each `:password`
input inside a `.pwd-see` form; clicking it toggles the input's `type` between `password` and
`text` and swaps `eye-open`/`eye-close` for the icon. Style those classes in your theme to
restyle the icon.

> Tip: find a form's id by inspecting the rendered `<form id="...">` (Drupal replaces
> underscores with dashes in the HTML id; use the underscore form here, e.g.
> `user_login_form`).
