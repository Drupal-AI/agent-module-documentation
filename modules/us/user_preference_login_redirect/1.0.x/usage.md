<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Preference Login Redirect lets users choose their post-login redirect destination (an internal route) from their profile.

---

User Preference Login Redirect **lets users pick their post-login landing page** — a profile preference where
each user selects, from configured options, the internal **route** they're redirected to after login (e.g. their
dashboard or the front page). It provides its own permissions.

Use it to give users a personalized post-login destination. It is a user-preference/UX feature. Security note: the
destination is chosen from **internal routes** (admin-configured route options, e.g. `<front>` or a named route),
not an arbitrary URL — so it is **not an open-redirect** vector (it redirects to internal Drupal routes). Keep the
selectable options to intended internal destinations. It has no access-control role beyond its permission.
Configure the redirect options.

---

- Let users pick a post-login destination.
- Choose from configured internal routes.
- Personalize the landing page.
- Provide its own permissions.
- Serve user preference/UX.
- Redirect after login.
- Redirect to internal ROUTES (not arbitrary URLs) - NOT an open-redirect vector.
- Use admin-configured route options.
- Keep options to intended internal destinations.
- Have no access-control role beyond permission.
- Configure the redirect options.
- Handle the login redirect.
- Redirect users.
- Configure the routes.
- Set the destination.
- Handle the login.
- Land users.
- Choose destinations.
- Restrict the options.
- Provide a login-redirect preference.
