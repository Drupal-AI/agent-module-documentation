<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Url Restriction by Role lets an administrator restrict access to specific URLs (paths, with wildcard and alias support) so that only chosen roles may view them; everyone else gets a 403 or a custom message.

---

The module is a single kernel `REQUEST` event subscriber (`src/EventSubscriber/UrlRestrictionByRole.php`)
plus one admin form. On every request it loads a list of configured URLs from
`url_restriction_by_role.settings` and, for each enabled entry, checks the current internal path **and**
its path alias against the configured pattern with core's `path.matcher` (so `*` wildcards work). Each
entry stores an "Allowed Roles" set: for the normal (multi-value) case, a user who has **none** of the
allowed roles is denied. When denied, the subscriber either issues the site's configured 403 page
(`system.site` `page.403`, or `/system/403`) or, if "use custom error message" is enabled, returns a raw
403 `Response` with the admin-defined message (default "You do not have access to this page"). The admin
form at `/admin/config/search/path/url-restriction-by-role` (permission `admin url restriction by role
settings`, `restrict access: true`) is a table where you add a URL, toggle **Enabled**, and pick the
allowed roles; a validator rejects URLs containing a dot. It is an **allow-list of restricted paths**:
paths not listed are unaffected (no global default-deny). The module ships no config schema and no Drush
commands. Note the operational caveats in the configure doc: matching is exact/wildcard
on the path string (case- and normalisation-sensitive), and because the check runs as a request
subscriber it is not applied for anonymous users when core's Internal Page Cache serves a cached page.

---

- Restrict `/admin/reports` (or any path) to a specific set of roles.
- Hide `/node/add` and other content-authoring paths from lower-trust roles.
- Block a section of the site (e.g. `/members/*`) from users who lack a "member" role.
- Use a wildcard pattern to protect a whole path prefix at once.
- Restrict a page by its URL alias as well as its internal path.
- Return the site's standard 403 page to unauthorised users.
- Show a custom "no access" message instead of the default 403 page.
- Allow only editors/administrators to reach a reporting or dashboard path.
- Gate a landing page so only authenticated users (a chosen role) can see it.
- Temporarily disable a restriction without deleting it (the Enabled toggle).
- Manage several URL restrictions from one admin table.
- Complement Drupal's route/permission access with a coarse path-based rule.
- Restrict URLs that are not otherwise permission-gated (e.g. a static alias).
- Limit access to a promotional or beta path to a specific role.
- Apply per-path role gating without writing a custom route access checker.
- Quickly lock down a path during an incident by adding and enabling a rule.
