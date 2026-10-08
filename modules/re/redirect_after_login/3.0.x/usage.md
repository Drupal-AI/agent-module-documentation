Redirect After Login sends a user to a configured internal URL immediately after they log in, with a different destination configured per user role.

---

Redirect After Login is a lightweight, core-only module (no contrib dependencies) that redirects users to a chosen path once they authenticate. On `hook_user_login` it looks up a per-role map of destination URLs stored in the `redirect_after_login.settings` config object under `login_redirection`, picks the URL for the user's role, and rewrites the request's `destination` query parameter so Drupal lands the user there. Because a user can hold several roles, priority is resolved by taking the last role in the user's role list (`array_reverse($roles)[0]`); if no URL is set it falls back to `/`. Destinations must be internal paths that start with `#`, `/`, or `?` (or the literal `<front>` token, saved as `/`), validated on the settings form. A newline-separated `exclude_urls` list (supporting the `*` wildcard) lets you skip redirection when login happens on certain pages, and password-reset routes are always skipped. A `RedirectAfterLoginEvent` is dispatched so other modules can change the target URL or cancel the redirect entirely, and a `hook_passwordless_login_redirect_alter()` implementation integrates with passwordless login. It is a simpler, per-role-only alternative to the more configurable Login Destination module. Configure it at **Admin → Configuration → People → Redirect After Login** (`/admin/config/people/redirect`), also linked from People as "Set Login Destination".

---

- Send editors to the content overview (`/admin/content`) right after they log in.
- Land administrators on the admin dashboard (`/admin`) on login.
- Redirect ordinary authenticated users to their profile or a member dashboard.
- Give each user role its own post-login landing page from one settings form.
- Point a "customer" role at an account/orders page after sign-in.
- Send a "contributor" role straight to the node-add screen.
- Route users to the site front page after login using the `<front>` token.
- Redirect to a fragment or query-string URL (paths starting with `#` or `?`).
- Fall back to `/` automatically when a role has no destination configured.
- Prioritize which destination wins for multi-role users (last role in the list applies).
- Exclude specific pages from redirection with a wildcard exclude list.
- Skip redirection on selected paths (e.g. keep a custom login landing intact).
- Preserve an explicit `?destination=` deep link by not overriding it.
- Avoid interfering with password-reset / one-time-login flows (auto-skipped).
- Keep users out of protected areas during maintenance mode by falling back to `/`.
- Programmatically change the post-login target from a custom module via the event.
- Cancel the post-login redirect entirely for certain users via the event.
- Integrate the per-role destination with passwordless login via the alter hook.
- Enforce internal-only redirects (external URLs are rejected by validation).
- Deploy per-role login destinations between environments as exported config.
- Restrict who can edit login destinations with a dedicated permission.
- Provide a simpler alternative to Login Destination when you only need per-role rules.
- Direct newly onboarded users of a given role to a getting-started page.
- Send support-staff roles to a ticket queue immediately after login.
- Route a "member" role to a paywalled or members-only landing page.
