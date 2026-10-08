<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Anonymous Login forces anonymous visitors to log in before viewing configured page paths, then returns them to the page they requested.

---

The module registers an event subscriber (`anonymous_login.redirect`) on the `KernelEvents::REQUEST` event (priority 100). On each anonymous request it compares the current path (and its alias) against a configured list of paths using Drupal's path matcher, with `*` wildcards supported. Paths are stored in one config object, `anonymous_login.settings`, as a `paths` sequence: a plain entry is an **include** (forces login) and an entry prefixed with `~` (tilde) is an **exclude**. When an included path matches (and no exclude matches), the anonymous user is redirected to `login_path` (default `/user/login`) with `?destination=<requested-alias>` so they land back on the page after logging in, and an optional `message` is shown as a status message. Matching an excluded path is a hard stop for that request. The module always excludes `user/reset/*`, `cron/*`, and `sites/default/files/*`, and skips redirection on the login page itself, `.php` requests, CLI, maintenance mode, and authenticated users. Other modules can adjust the lists via `hook_anonymous_login_paths_alter()`. Configuration lives at *Configuration → User interface → Anonymous login* and is gated by the `administer anonymous login settings` permission.

---

- Force anonymous users to log in before viewing the entire site by including the path `*`.
- Gate a members-only section (`/members/*`) behind login while leaving the rest of the site public.
- Require login to view any node (`/node/*`) but keep the homepage public with a `~` exclude.
- Protect a documentation area (`/docs/*`) so only authenticated users can read it.
- Lock down a staging/pre-launch site so every page redirects anonymous visitors to log in.
- Include a broad path but exclude a sub-path, e.g. include `/reports/*` and exclude `~/reports/public/*`.
- Redirect anonymous users hitting `/dashboard` to the login page and back after authentication.
- Keep the requested page as the post-login `destination` so users are not dumped on the front page.
- Show a custom status message (e.g. "Please log in to view this page") when redirecting.
- Point the login redirect at a custom login route by setting `login_path` (e.g. an SSO login path).
- Combine wildcard includes (`/private/*`) with specific excludes (`~/private/teaser`).
- Protect user profile pages (`/user/*`) while the module still auto-excludes password reset links.
- Require login for a commerce checkout preview area while leaving product pages public.
- Force login on search results (`/search/*`) to hide indexed content from anonymous users.
- Programmatically add always-on include/exclude paths from a custom module via `hook_anonymous_login_paths_alter()`.
- Exclude the front page from a site-wide include so the landing page stays public.
- Restrict a multilingual section; the module resolves aliases and language prefixes when matching.
- Keep API/file paths reachable by relying on the built-in `sites/default/files/*` exclusion.
- Use path aliases in the include list (the subscriber checks both the internal path and its alias).
- Deploy the whole configuration as code by exporting `anonymous_login.settings`.
- Temporarily make a section private by adding its path, then public again by removing it.
