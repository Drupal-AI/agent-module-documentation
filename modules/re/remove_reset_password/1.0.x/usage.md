Remove'Reset your password' lets an administrator hide the "Reset your password" tab (and optionally all local tabs) on the user login page, and blocks the password-reset route itself for anonymous users.

---

The module adds a small settings form at `/admin/config/people/reset-password-form-settings`
(*Configuration → People → Remove Reset password*, route
`remove_reset_password.remove_reset_password`, gated by core's `administer site configuration`
permission) with two checkboxes stored in `remove_reset_password.settings`:
`remove_reset_password_button` (hide just the *Reset your password* tab for anonymous users)
and `remove_all_local_tabs` (hide **all** local tabs on the login page). A
`hook_menu_local_tasks_alter()` implementation removes the corresponding tab(s) (`user.pass`,
or every tab under `data['tabs'][0]`) on the `user.login` route when the flags are set — a
purely visual change. In addition, a request event subscriber (`PasswordSubscriber`, priority
30) enforces the hiding server-side: when `remove_reset_password_button` is on and the current
user is **anonymous**, any request to the `user.pass` route throws `AccessDeniedHttpException`,
so the password-reset page cannot be reached by directly visiting the URL. The subscriber only
acts on `user.pass`, only when the button is hidden, and only for anonymous users, so it fails
closed (authenticated users and all other routes are unaffected). There is no config schema
shipped and no permission of its own. Note `remove_all_local_tabs` only hides the tabs
visually; the standalone route block is tied to `remove_reset_password_button`.

---

- Hide the "Reset your password" tab on the login page for anonymous visitors.
- Also block direct visits to `/user/password` for anonymous users (server-side deny).
- Hide every local tab on the login page for a cleaner, single-purpose login screen.
- Enforce SSO/external-auth flows by removing the built-in password reset entry point.
- Reduce the login UI to just "Log in" where self-service reset isn't wanted.
- Steer users to an alternative/help-desk-driven password recovery process.
- Simplify the login interface on kiosk or intranet sites.
- Prevent password-reset emails being triggered by anonymous visitors.
- Turn the reset tab back on by unchecking a box (reversible, config-only).
- Keep authenticated users' access to reset flows untouched while blocking anonymous.
- Customise the login page without a custom theme override.
- Combine with SSO modules to present a login page with no local password reset.
- Meet a policy requiring the public reset form to be disabled.
- Toggle behaviour per environment via config override in `settings.php`.
- Remove the reset link where accounts are provisioned centrally only.
