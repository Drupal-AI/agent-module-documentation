<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drush commands that list a site's headless/decoupled API routes and audit them for open access and access-control misconfigurations.

---

API Audit Drush Command adds two Drush commands for reviewing the API surface of a headless or decoupled Drupal site. `api:route` lists every API route (any route with a non-HTML `_format` requirement, plus `jsonapi.*` and `rest.*` routes) or dumps the full definition of one route by name or path. `api:audit:permission` walks the same route set and flags each route that is (or may be) reachable without adequate access control: unconditional `_access: 'TRUE'`, a `_permission` actually granted to the anonymous role, `_role: 'anonymous'`, `_user_is_logged_in: 'FALSE'`, a `_custom_access` callback needing manual review, or no access requirement at all. Findings are graded info / warning / critical, escalated for write methods (POST/PUT/PATCH/DELETE) and de-escalated for JSON:API config-entity routes (which rely on entity access). The module reads route and entity/role definitions only — it makes no changes and exposes no web routes, forms, permissions, or configuration. It requires Drush 12 or 13; there is nothing to configure.

---

- List all API routes on the site: `drush api:route`.
- Inspect one route's full definition by name: `drush api:route --name=jsonapi.node--article.collection`.
- Inspect one route by internal path or full URL: `drush api:route --path=/jsonapi/node/article`.
- Get route details as YAML (default) or another format: `drush api:route --name=... --format=json`.
- Run a full access audit of the API surface: `drush api:audit:permission`.
- Add API auditing to a pre-release or deployment checklist to catch endpoints left open.
- Find write endpoints (POST/PATCH/DELETE) that lack access control before going to production.
- Show only actionable findings by filtering severity: `drush api:audit:permission --severity=warning`.
- Show only critical findings: `drush api:audit:permission --severity=critical`.
- Focus on custom/REST endpoints by hiding JSON:API routes: `drush api:audit:permission --exclude-jsonapi`.
- Audit only write operations, the highest-risk methods: `drush api:audit:permission --methods=POST,PATCH,DELETE`.
- Exclude known-safe or noisy routes by name or wildcard: `drush api:audit:permission --exclude-routes=system.*,jsonapi.user--user.*`.
- Export audit results for scripting or CI gating: `drush api:audit:permission --format=json`.
- Cross-check which anonymous-granted permissions expose API routes on the current site.
- Verify that JSON:API content-entity routes are not unintentionally exposing user data.
- Confirm that config-entity JSON:API routes are protected by admin-only entity access.
- Skip JSON:API resources you have disabled via jsonapi_extras (auto-excluded from the audit).
- Review `_custom_access` routes surfaced by the audit for manual security assessment.
- Produce a route inventory for documentation of a decoupled front-end integration.
- Detect routes with no access requirement defined at all.
- Compare API exposure before and after enabling or updating contrib modules.
