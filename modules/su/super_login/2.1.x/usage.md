Super Login enhances Drupal's core login, registration and password-reset forms with configurable text, placeholders, a caps-lock warning, autofocus, optional CSS, and the ability to log in with a username, an email address, or either.

---

Super Login is a form-alteration module: `hook_form_alter()` rewrites the `user_login_form`, `user_register_form` and `user_pass` forms. All behaviour is driven by a single config object `super_login.settings` (whose values are nested under a `super_login.*` key path) edited at *Configuration → People → Super Login Settings* (route `super_login.settings`, path `/admin/config/people/super_login/settings`). It lets you relabel the username field, the login/register buttons, the forgot-password and "create new account" links and the page titles; add placeholder text and autofocus to the username field; show a caps-lock warning (via `js/super-login.js`); move Drupal status messages outside the form; and toggle the module's own stylesheet. Its headline feature is **Login Type** (`login_type`): `0` = username *or* email, `1` = username only, `2` = email only — implemented by a validate handler (`super_login_user_login_validate`) that looks up the account by email and swaps in the real username before core authenticates. It also cleans up the login/password pages by removing the login/register/reset local task tabs (`hook_menu_local_tasks_alter`) and unsetting the default field descriptions. There is no permission of its own (the settings form uses core's *administer site configuration*), no Drush, and no plugins.

---

- Let users log in with their email address instead of (or as well as) their username.
- Restrict login to email-address-only, or to username-only, via the Login Type setting.
- Add a "Forgot password?" link directly under the login form with custom anchor text.
- Add a "Create new account" link beside the login button (respecting the site's registration setting).
- Show a "Caps Lock is on" warning while a user types their password.
- Relabel the username field (e.g. "Username or e-mail address") on the login form.
- Customise the login and registration submit button text.
- Set a custom title above the login form and above the password-reset form.
- Add placeholder text inside the username and password fields.
- Autofocus the username field on page load so users can start typing immediately.
- Move Drupal's system/status messages outside the login form for a cleaner layout.
- Enable or disable the module's bundled CSS so you can style the login page from your theme instead.
- Add a "Go back to the login page" link on the registration and password-reset pages.
- Remove the Log in / Reset password / Create account tabs from the login and reset pages.
- Provide a friendlier, less cluttered login experience without a custom theme.
- Standardise login-page copy across a multisite via exported `super_login.settings` config.
- Turn off autocomplete on the login form when no registration link is shown.
- Localise or rebrand all login/registration strings from one settings form.
- Give a corporate intranet an email-only sign-in flow.
- Strip the default "Enter your username" / password field descriptions for a minimal form.
- Widen the username and password inputs (size 50) for readability.
- Configure the caps-lock warning message text shown to users.
- Deploy consistent login UX by shipping the config object in a feature/recipe.
- Set the password-reset page title and its "back to login" link text.
- Keep query parameters (e.g. destination) on the forgot-password and register links.
