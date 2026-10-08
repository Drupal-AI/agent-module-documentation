# How Super Login alters the forms

Everything is in `super_login.module` (`hook_form_alter`) plus two small JS files and a
`RouteSubscriber` (currently a no-op — its overrides are commented out). No services to call.

## Forms touched

- **`user_login_form`** — sets the username `#title` (`login_text`), adds a login title,
  a "Forgot password?" link (→ `user.pass`), a "Create new account" link (→ `user.register`,
  only if registration isn't admin-only), an optional caps-lock warning div, placeholders,
  autofocus, wider inputs (`#size = 50`), attaches `super_login/super_login_js`, and passes
  `drupalSettings.show_messages`. Prepends the `login_type` validate handler.
- **`user_register_form`** (anonymous only) — sets the register button text (`reg_button_text`),
  removes the name/mail descriptions, adds a "back to login" link.
- **`user_pass`** — sets the reset page title (`password_reset_title`), a "back to login" link,
  attaches `super_login/super_login_pw_js`.

Both login and pass forms drop the default field descriptions and (when `css` is on) attach
the module stylesheet.

## Login by email — the Login Type mechanism

`super_login_user_login_validate()` runs **before** core login validation. Based on
`super_login.login_type`:

- **0 (username or email)** and **2 (email only)**: it lowercases/trims the entered name,
  and if an active user has that value as their **email**, it replaces the submitted `name`
  with that account's real username so core can authenticate.
- For type **2**, if no account matches the email, it sets the name to `-` so a bare username
  cannot succeed (effectively email-only).
- **1 (username only)**: no lookup — core behaviour (username as entered).

So "log in with email" is not a separate auth path; it is a name-substitution done in a
validate handler. The account lookup uses an entity query on `mail` with `status = 1`.

## Other UI cleanup

- `hook_menu_local_tasks_alter()` removes the Log in / Reset password / Create new account
  **tabs** from `user.login`, `user.pass` and `user.register` so the pages show only the form.
- Caps-lock detection is client-side (`js/super-login.js`); the warning markup is only added
  when `capslock` is true.

## Extending

There are no hooks or events to implement. To change behaviour, override the config values
(see [configure/settings.md](../configure/settings.md)) or, for deeper changes, alter the
same forms at a later weight in a custom module.
