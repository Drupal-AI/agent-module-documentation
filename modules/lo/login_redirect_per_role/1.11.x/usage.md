<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Login And Logout Redirect Per Role sends users to a role-specific URL after they log in or log out, choosing the destination by the user's roles and a configurable per-role priority.

---

The module adds one admin form (`/admin/people/login-and-logout-redirect-per-role`, permission *administer site configuration*) that stores two tables — **Login redirect** and **Logout redirect** — in the config object `login_redirect_per_role.settings`. Each table has one row per role (anonymous excluded) with a **Redirect URL**, an **Allow destination** checkbox, and a **Weight**. On `hook_user_login` and `hook_user_logout` the `login_redirect_per_role.service` sorts the rows for that action by weight (ascending = higher priority), walks them in order, and for the first role the user actually has whose Redirect URL is non-empty it sets Drupal's `destination` query parameter so core redirects there. A Redirect URL may be `<front>`, an internal path beginning with `/`, `?` or `#`, or a token such as `[current-user:uid]` (Token module). If **Allow destination** is ticked and the request already carries a `destination`, that existing destination is respected instead. Login redirects are suppressed on password-reset and Commerce checkout routes (`user.reset*`, `commerce_checkout.form`, `change_pwd_page.reset`, and `tfa.entry` while a pass-reset token is present). It ships config schema but no permissions of its own, no Drush commands, and no plugins.

---

- Send editors to `/admin/content` right after they log in, while other users keep the default login behavior.
- Land administrators on `/admin/dashboard` on login instead of their user profile page.
- Redirect members of a "customer" role to a `/my-account` landing page after login.
- Send everyone to the front page (`<front>`) on logout with a single Authenticated-role row.
- Take users to a `/goodbye` thank-you page when they log out.
- Give each role its own post-login home without writing a custom `hook_user_login`.
- Use role priority (weight) so a user with both *Manager* and *Authenticated* lands on the Manager URL.
- Redirect to a personalized path with a token, e.g. `/user/[current-user:uid]/edit`.
- Keep a requested `?destination=` intact for a role by ticking **Allow destination** (e.g. deep links from email).
- Force a fixed landing page for a role by leaving **Allow destination** unticked so the role URL always wins.
- Route content editors to a Views-based editorial dashboard on login.
- Send support agents to an open-tickets queue page immediately after signing in.
- Provide a role-specific onboarding page for newly assigned roles.
- Redirect anonymous-turned-authenticated users away from the login form to a welcome page.
- Configure different login and logout destinations for the same role in one place.
- Avoid interrupting Commerce checkout — the module deliberately skips the checkout route.
- Preserve the normal one-time-login/password-reset flow, which the module leaves untouched.
- Order roles by drag-and-drop weight to express which role's redirect takes precedence.
- Export the `login_redirect_per_role.settings` config for deployment across environments.
- Point a role at an anchor or query-only URL (`#section`, `?tab=x`) after login.
- Integrate with CAS-based single sign-on so redirects apply to CAS logins too.
- Set up a "no redirect" role by leaving its Redirect URL empty so default Drupal behavior applies.
- Give a temporary campaign role a promotional landing page on login.
- Centralize all login/logout redirect logic in config instead of scattered custom code.
