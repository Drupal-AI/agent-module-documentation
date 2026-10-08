Email Registration lets people register and log in with their email address instead of a separate username, auto-generating a Drupal username behind the scenes so the extra "username" field never gets in the way.

---

On registration and login the module alters the core user forms: the email field becomes required, the username field is hidden (rendered as a `value`) for users who lack the "change own username" or "administer users" permissions, and on the login form the "Username" label/field becomes an email field that authenticates by looking the account up with `user_load_by_mail()`. Because core still requires a stored username, `hook_user_presave` generates one — by default `email_registration_strip_mail_and_cleanup()` takes the part of the email before the `@`, strips illegal characters, and `email_registration_unique_username()` appends `_1`, `_2`, … to guarantee uniqueness. The generated name is customizable via `hook_email_registration_name_alter()` (the old `hook_email_registration_name()` is deprecated in 2.0 and removed in 3.0). A single setting, `login_with_username` (default false), decides whether people may sign in with either their email or their username. A "Update username (from email_registration)" bulk action (a `user` action plugin) lets you regenerate usernames for existing accounts from the People view, and a `RouteSubscriber` swaps the `user.login.http` REST/JSON login controller so API logins accept email too. It also ships a Commerce checkout login pane, a D7 migrate process plugin, and the `email_registration_username` submodule. Configuration lives on the core Account settings form (`entity.user.admin_form`, `/admin/config/people/accounts`); the module defines no permissions of its own.

---

- Let users register with only an email address and password, no separate username to invent.
- Let users log in with their email address instead of a username.
- Optionally allow login with either email address or username (`login_with_username`).
- Auto-generate a Drupal username from the local part of the email (before the `@`).
- Guarantee generated usernames are unique by suffixing `_1`, `_2`, and so on.
- Hide the username field on the registration/edit form from users without permission to change it.
- Keep the email field required on the account and registration forms.
- Authenticate REST/JSON:API `user.login.http` logins by email address.
- Adjust a Drupal Commerce checkout flow to log in / register customers by email via the provided pane.
- Regenerate usernames for many existing users at once with the "Update username" bulk action on the People view.
- Customize the auto-generated username pattern with `hook_email_registration_name_alter()`.
- Clean up an arbitrary string into a legal username with `email_registration_cleanup_username()`.
- Derive a username from an email address in custom code with `email_registration_strip_mail_and_cleanup()`.
- Generate a collision-free temporary username via the `email_registration.username_generator` service.
- Let privileged users still set an explicit username by leaving the field editable for them.
- Show a helpful "leave empty to generate from email" hint to admins on the create-user form.
- Migrate Drupal 7 email_registration settings/usernames with the bundled migrate process plugin.
- Replace `[user:display-name]` with `[user:mail]` in the welcome email so new users get a sensible greeting.
- Grant "change own username" so end users can override their generated name in My Account.
- Detect and warn about a login conflict with the LoginToboggan module at install time.
- Provide an email-based password-reset ("Forgot password") form that accepts the email address.
- Extend email-as-username behavior further with the `email_registration_username` submodule (full sync).
- Build a passwordless/email-first signup UX without a custom user form.
- Reduce signup friction and abandoned registrations by dropping the username step.
- Keep usernames private-ish while still exposing a login flow keyed on email.
