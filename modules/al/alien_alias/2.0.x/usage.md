<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Alien Alias provides a redirect system that links site paths to external URLs, resolved early in the request via a kernel event subscriber for fast responses.

---

Install the module and manage Alien alias entities (permissions: add/edit/delete/administer/view alien alias entities). A route subscriber builds routes; on each request the subscriber matches the path against the {router} table and, for _exogen routes, issues a TrustedRedirectResponse to the configured external URL. The alien_alias_fast_response setting toggles early handling.

---

- Redirect site paths to external URLs.
- Manage aliases as configurable entities.
- Resolve aliases early via a kernel request subscriber.
- Look up the path in the core {router} table.
- Issue a TrustedRedirectResponse for external targets.
- Record access stats per alias.
- Support fast-response handling via a setting.
- Provide granular entity permissions.
- Restrict administration via a restricted permission.
- Append query parameters to the target URL.
- Serve redirect/entity-behaviour use cases.
- Return a 404 when stat recording fails.
- Deserialize route data from the trusted router table.
- Support published/unpublished alias views.
- Redirect to admin-configured external URLs (by design).
- Keep processing minimal for matched aliases.
- Work across Drupal 9 and 10.
- Provide an add-alias creation permission.
