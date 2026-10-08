After Login/Logout Redirection (alr) lets an administrator set a per-role destination that users are sent to after they log in and after they log out.

---

The module adds one admin settings form at `/admin/config/alr-configuration` that lists every non-anonymous user role in two weighted, draggable tables — one for after-login redirects and one for after-logout redirects. For each role you enter an optional redirect path (a valid internal path starting with `/`, or an external URL starting with `http`/`https`); leaving it blank means no redirect for that role. Values are stored in the `alr.settings` config object. At runtime, alr appends a submit handler to the core `user_login_form` and implements `hook_user_logout()`. Both look up the current user's first alphabetically sorted role, read that role's configured `redirect_url`, and set it as the request `destination` — but only when the incoming request does not already carry a `destination` query parameter, so a link that already specifies `?destination=` is respected and Drupal's standard redirect handling still applies. The module ships no entities, services, permissions, plugins, blocks, or Drush commands.

---

- Send authenticated users to a role-specific dashboard immediately after login.
- Redirect editors to the content admin listing after they log in.
- Redirect administrators to the admin dashboard after login.
- Land regular members on their account or profile page after login.
- Point a "customer" role at a storefront or account area post-login.
- Take users to a marketing or thank-you landing page after logout.
- Send logged-out users back to the site home page instead of the front controller default.
- Redirect logged-out staff to an external SSO or portal URL.
- Configure different post-login landing pages for different roles on one site.
- Give each role its own post-logout destination.
- Override Drupal's default post-login redirect without writing custom code.
- Set a fixed internal landing path for a specific role.
- Use weights to order the per-role rows in the configuration tables.
- Leave a role's field blank to opt that role out of any redirect.
- Respect an existing `?destination=` on the login link (module does not override it).
- Provide a simple, config-only redirect layer with no external dependencies.
- Direct newly logged-in users straight to a members-only section.
- Route users to a survey or onboarding flow after their first login session.
- Centralize login/logout landing rules for a multi-role site in one form.
- Ship the redirect settings between environments via exported configuration.
