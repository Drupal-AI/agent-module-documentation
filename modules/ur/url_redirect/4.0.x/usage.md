<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
URL Redirect issues a 301 redirect when a logged-in user visits a configured path, based on the user's role or specific user identity. Redirect rules are stored as `url_redirect` config entities and managed at `/admin/config/system/url_redirect`.

---

The module defines a `url_redirect` config entity (one per rule) and a kernel `REQUEST` event subscriber (`RedirectSubscriber`, priority 33, before the router) that inspects the incoming path. Each rule has a source `path`, a `redirect_path`, a `redirect_for` selector (`Role` or `User`), a list of `roles` or `users`, a `negate` flag, a `message` toggle (`Yes`/`No`), and a `status` (enabled/disabled). On each request the subscriber matches the current path against enabled rules — supporting exact matches, the `<front>` alias for `/`, and `*` wildcards via the core `path.matcher` service — then checks whether the current user matches the rule's roles (`array_intersect` of the user's roles) or is one of the listed users. If so it returns a `TrustedRedirectResponse(…, 301)`: external targets (`http(s)://…`) are used as-is, `<front>` and empty targets go to the front page, and internal targets are prefixed with the site base URL. It also runs on `EXCEPTION` events for 403 responses, so it can redirect users away from access-denied pages. The `negate` flag inverts the role/user match. An optional status message is shown after redirecting when `message` is `Yes`. The module ships three permissions gating the settings, edit, and delete pages, and a config schema for the entity; it has no Drush commands and no plugins.

---

- Send anonymous users hitting a members-only path to the login or home page.
- Redirect users with a specific role (e.g. "customer") away from an admin path to a dashboard.
- Redirect a named user to a custom landing page whenever they visit a given URL.
- Bounce non-privileged roles off `/admin` to the front page.
- Redirect a role to an external URL (e.g. a hosted portal) with a 301.
- Use `<front>` as the source to redirect the home page for certain roles or users.
- Apply a wildcard rule like `/reports/*` to redirect an entire section for a role.
- Redirect users away from a 403 access-denied page to a friendlier destination.
- Send a specific user to `/welcome` on their first configured path visit.
- Negate a rule so it redirects everyone *except* the listed roles.
- Negate a rule so it applies to all users other than the specified ones.
- Show a status message ("You have been redirected to …") after the redirect when desired.
- Temporarily disable a redirect rule by setting its status to Disabled without deleting it.
- Route different roles to different homepages by stacking several `<front>` rules.
- Redirect legacy internal paths to new ones for a subset of users during a migration.
- Force editors to a moderation dashboard when they open the default content listing.
- Keep contributors out of a section by redirecting the section path for their role.
- Redirect authenticated users from the login page to their account or dashboard.
- Manage all redirect rules from one admin collection page at `/admin/config/system/url_redirect`.
- Grant delegated staff access to only add/edit or only delete redirect rules via the three permissions.
- Deploy redirect rules as configuration (`url_redirect.url_redirect.*`) across environments.
- Prefix internal redirect targets automatically with the site base URL.
- Point several roles at the same destination by listing multiple roles on one rule.
- Restrict a marketing campaign path to redirect only a chosen user segment (by user list).
- Combine role-based redirects with wildcards to gate whole URL trees per role.
