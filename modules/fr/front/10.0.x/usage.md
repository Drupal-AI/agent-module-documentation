<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Front Page (machine name front_page) overrides the Drupal front page per user role: when a role's override is enabled, a request to the front page is redirected to an admin-chosen local path, with the lowest-weight enabled role winning. It can also repoint site `<front>` HOME links to a different local path.

---

Front Page (machine name front_page) lets an administrator configure, from a settings form under Configuration › System › Front, one redirect target per user role plus a master enable switch and an optional exemption for administrators. On the front page, an event subscriber picks the enabled role override with the lowest weight and issues a 302 redirect to that admin-configured local path, carrying over the request's query parameters and disabling the page cache for that response. A separate outbound path processor rewrites `<front>`/HOME links to an admin-set path. All configuration lives in the single `front_page.settings` config object and is gated by the `administer front page` permission. No external services, plugins, or Drush commands are involved.

---

- Show different front pages to different roles.
- Send anonymous visitors to a marketing or landing page.
- Route authenticated users to a dashboard on login-home.
- Send editors to a content work queue as their home page.
- Give members an app-style home while the public sees a splash page.
- Set redirect precedence between roles using per-role weights.
- Exempt the administrator role from front-page redirects.
- Enable or disable the whole override with one switch.
- Redirect the front page to any valid local path (e.g. /node/12).
- Preserve incoming query parameters through the front-page redirect.
- Repoint site HOME links away from the default front page.
- Rewrite `<front>` links to a chosen local path.
- Stop users returning to a splash screen via HOME links.
- Restrict who can change front-page settings to a single permission.
- Configure front pages without writing custom code.
- Vary the site entry point by audience.
- Clear a role's front-page override automatically when the role is deleted.
- Keep front-page config in exportable configuration.
- Set the front page per role via Drush or config import.
- Point a role's home at a path with query and fragment (e.g. /node/51?page=5#anchor).
