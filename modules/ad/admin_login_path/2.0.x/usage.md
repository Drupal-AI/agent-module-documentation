Admin Login Path makes Drupal's user account pages (login, register, password reset, account cancel) render with the site's **administration theme** instead of the front-end theme, by flagging those routes as admin routes.

---

Despite its name, this module does **not** move, rename, or hide the `/user/login` path — it is not a login-path relocation or security-through-obscurity tool, and it does not block, restrict, or add any protection to the default login URL. It is a zero-configuration theming helper: a `RouteSubscriber` (event subscriber) sets the `_admin_route` option to `TRUE` on a fixed list of core account routes (`user.login`, `user.register`, `user.pass`, `user.cancel_confirm`, `user.reset`, `user.reset.login`, `user.reset.form`), which makes Drupal's theme negotiator serve them with the configured admin theme. So that anonymous visitors can actually see the admin theme on the login/register pages, `hook_install()` grants the core `view the administration theme` permission to both the anonymous and authenticated roles. There is no settings form (`configure` is null), no permissions of its own, no Drush commands, and no config schema. Uninstalling removes the route alteration; the granted `view the administration theme` permission is not automatically revoked on uninstall. Note the module only affects theming — the default account paths remain reachable exactly as in core.

---

- Render the `/user/login` page with the administration theme so it matches the admin backend look.
- Show the user registration page (`/user/register`) in the admin theme.
- Show the forgotten-password / reset request page (`/user/password`) in the admin theme.
- Render the one-time-login / password reset form pages in the admin theme.
- Render the account cancellation confirmation page in the admin theme.
- Give staff-facing login screens a consistent branded admin appearance without a custom theme negotiator.
- Avoid writing a custom `hook_theme_registry` / theme negotiator just to admin-theme the login flow.
- Provide a cleaner login UI when the front-end theme is heavily customized or minimal.
- Present login pages using Claro/Gin (or any admin theme) for a familiar staff experience.
- Ensure anonymous users can view the admin theme on the account pages (auto-granted permission).
- Pair with an admin theme like Gin to give editors an on-brand sign-in experience.
- Standardize the look of all account-management pages behind one enable step.
- Use as a lightweight alternative to modules that fully relocate the login path (this one does not relocate it).
- Quickly theme login pages on a site where you cannot deploy custom theme code.
- Keep the front-end theme free of login-form styling concerns.
- Match the login page theme to the destination editors land on after signing in.
- Roll out admin-themed account pages across a multisite by simply enabling the module.
- Revert instantly by uninstalling — routes return to the front-end theme.
- Diagnose theme-negotiation behavior by observing `_admin_route` being applied to account routes.
