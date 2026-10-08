<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Frontpage for Authenticated Users sends logged-in visitors to a different front page from anonymous ones: when an authenticated user hits `/`, a kernel event subscriber redirects them to an admin-chosen node or internal path.

---

Drupal has a single front page setting, so a site whose public homepage is a marketing page but whose members expect a dashboard has to choose one or bolt on custom logic. This minimal module adds that logic. Its event subscriber (`authenticated_frontpage.event_subscriber`) runs on every front-controller request: when an authenticated user requests the site front page, it issues a 302 redirect to the configured target — a node (by id) or an internal path — carrying the incoming query string. The target page is then flagged via a request attribute so `authenticated_frontpage_preprocess_page()` sets `is_front = TRUE`, making the theme render it like the homepage. Targeting can be narrowed to selected roles (no roles selected means all authenticated users), and an optional toggle redirects anonymous visitors away from the authenticated front page to the site's default front page. Everything is stored in the `authenticated_frontpage.settings` config object and edited at `/admin/config/system/authenticated-frontpage`, behind the `administer authenticated_frontpage configuration` permission (marked `restrict access: true`). There are no dependencies beyond core and the range is a wide `^8 || ^9 || ^10 || ^11`. Because the mechanism is a redirect, the browser URL changes to the target path; for genuinely different front pages per role, the maintainers point to the `front` module. Access to the target page is enforced normally on the redirected request.

---

- Send members to a dashboard when they visit the site root.
- Keep a marketing homepage for anonymous visitors.
- Redirect logged-in users from `/` to a chosen node.
- Point authenticated users at an internal path such as `/user/me`.
- Show a members' feed as the logged-in landing page.
- Give an intranet a public landing page and a members' home.
- Limit the alternate front page to specific roles (e.g. editors).
- Apply the alternate front page to all authenticated users at once.
- Hide the members' front page from anonymous users by redirecting them.
- Present onboarding content to newly registered members.
- Give staff a task list as their front page.
- Configure the target front page without writing code.
- Restrict who can change the setting to trusted administrators.
- Support a community site with a public face and a member home.
- Make the target page render with front-page templates and body class.
- Preserve query-string parameters through the redirect.
- Keep anonymous SEO content on the real homepage untouched.
- Run on a site still on Drupal 8 through 11.
- Replace a bespoke event subscriber that overrides the front page.
- Combine role targeting with an anonymous-redirect for a members-only home.
