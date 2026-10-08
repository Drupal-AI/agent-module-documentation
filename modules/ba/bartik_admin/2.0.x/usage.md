<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bartik Admin lets the classic Bartik look serve as an administration theme, with a per-user form to opt a given account into using it for back-end pages.

Use it if you prefer Bartik's styling for admin screens or want individual users to choose it as their admin theme.

---

Install with `composer require drupal/bartik_admin` and enable it (`drush en bartik_admin`).

Each user's preference is set at `/user/{user}/bartik-admin`, a route restricted to the `administrator` role plus a custom access check on the form. A theme negotiator then applies the Bartik-style admin theme for users who opted in.

---

- Offer a Bartik-styled administration theme.
- Let individual users opt into the admin theme.
- Provide a per-user settings form at `/user/{user}/bartik-admin`.
- Restrict the settings form to the `administrator` role.
- Add a custom access check on top of the role requirement.
- Use a theme negotiator to apply the admin theme conditionally.
- Keep the front-end theme unchanged.
- Support Drupal 8, 9 and 10.
- Provide a familiar Bartik interface for back-end work.
- Store the preference against the user account.
- Integrate with Drupal's theme-negotiation system.
- Avoid forcing the theme site-wide.
- Serve as an admin-theme alternative to Claro/Seven.
- Require no external libraries.
- Work alongside other admin tooling.
- Give administrators per-account control over admin styling.
- Bridge legacy Bartik styling into administration pages.