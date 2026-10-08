<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Page Expiration Testing (ape_test) is a small helper submodule of ape that registers a handful of routes/endpoints used to exercise APE's Cache-Control behaviour (redirects, alternative pages, excluded pages) in tests.

---

The submodule ships only routing plus one controller (`ApeTestController`) — no config, permissions, services, schema or hooks. It exposes five publicly-accessible paths (all `_access: 'TRUE'`): `/ape_redirect_301` issues a 301 redirect to `/ape_redirect_landing`; `/ape_redirect_302` issues a 302 redirect to the same landing page; `/ape_redirect_landing` renders a plain "Arrived at your final destination." markup page; and `/ape_alternative` and `/ape_exclude` render that same landing content, providing stable paths you can list in APE's *alternatives* and *exclusions* settings to verify that the alternative lifetime and the cache-exclusion policy actually take effect. It is intended to be enabled alongside `ape` (typically only in a test or development environment) so functional tests — and manual checks — can assert the `Cache-Control` header APE sets for redirects, alternative-cache pages and excluded pages. It has no user-facing value on a production site.

---

- Provide a stable 301-redirect endpoint (`/ape_redirect_301`) to verify APE's `lifetime.301` cache header.
- Provide a 302-redirect endpoint (`/ape_redirect_302`) to verify APE's `lifetime.302` cache header.
- Provide a landing page (`/ape_redirect_landing`) as the redirect target for those tests.
- Provide `/ape_alternative` as a path to add to APE's alternatives list and confirm the alternative lifetime applies.
- Provide `/ape_exclude` as a path to add to APE's exclusions list and confirm caching is denied.
- Assert the `Cache-Control: public, max-age=N` header for redirects in a functional test.
- Assert that excluded pages return `no-cache, must-revalidate`.
- Manually curl the endpoints to inspect the headers APE emits.
- Reproduce cache-header bugs against known, controller-backed routes.
- Enable it in CI/dev only, leaving it disabled in production.
- Serve as the fixture module referenced by ape's own PHPUnit tests.
- Confirm a 403/404 path behaves as APE expects alongside these 200/redirect endpoints.
- Validate APE configuration changes end-to-end without creating real content.
- Give QA reproducible URLs to check redirect caching behaviour.
- Demonstrate APE's per-status and per-path logic during development.
- Disable/uninstall it cleanly once testing is complete.
