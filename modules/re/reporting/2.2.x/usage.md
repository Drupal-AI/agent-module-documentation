<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Reporting implements the W3C Reporting API in Drupal: it defines "reporting endpoint" config entities, advertises them to browsers via a `Reporting-Endpoints` response header, and logs the violation/deprecation/CSP reports browsers POST back to internal endpoints (or forwards browsers to an external collector URI).

---

The module lets a Drupal site act as the collector for browser-generated reports (CSP violations, deprecation warnings, network errors, crash reports, etc.). You create one or more **Reporting Endpoint** config entities (`reporting_endpoint`, managed at `/admin/config/system/reporting`). Each endpoint is either **internal** (browsers post to Drupal's own intake URL) or **external** (browsers post directly to an `https://` third-party collector such as report-uri.com). A response subscriber adds a `Reporting-Endpoints` header listing every enabled endpoint's URL — the internal intake URL `/system/reporting/{id}` for internal endpoints, or the configured `external_uri` for external ones — using structured-field serialization (the `gapple/structured-fields` library). For internal endpoints, browsers POST reports to that URL; the `ReportingEndpoint::log` controller accepts `application/reports+json` (Reporting API) and `application/csp-report` (legacy CSP `report-uri`, including Firefox's variant which it normalizes), validates them, and writes each report to Drupal's logger (`reporting` channel) as pretty-printed JSON. Disabled endpoints, and the local intake URL of an external-type endpoint, return `410 Gone`. If `dblog` is on, a "Recent violation reports" report at `/admin/reports/reporting` renders the logged entries in a table. The module also ships a `csp` integration plugin (`ReportTo`) so the Content-Security-Policy module can point its `report-uri`/`report-to` directives at a chosen reporting endpoint (internal or external). Admin routes require `administer site configuration`; the report page requires `access site reports`; the internal intake endpoint itself is public (browsers post without authentication, by design).

---

- Collect Content-Security-Policy violation reports from visitors' browsers into Drupal's log.
- Provide a `report-uri`/`report-to` target for the Content-Security-Policy (`csp`) module via the bundled ReportTo plugin.
- Advertise reporting endpoints to browsers with a standards-based `Reporting-Endpoints` header.
- Point browsers at an **external** report collector (e.g. report-uri.com) by configuring an `https://` external URI instead of the internal intake.
- Capture browser **deprecation reports** to learn which deprecated web features your site still uses.
- Gather **intervention reports** (features the browser blocked, e.g. autoplay) for debugging.
- Log **network error logging (NEL)**-style and crash reports posted by browsers.
- Run a first-party CSP report collector instead of relying on a third-party SaaS.
- Review recent violation reports in the admin UI at `/admin/reports/reporting` (with dblog enabled).
- Normalize Firefox's non-standard `csp-report` payload into the Reporting API format automatically.
- Temporarily disable an endpoint (returns 410 Gone) without deleting its configuration.
- Maintain multiple named endpoints (e.g. one internal for CSP, one external for deprecations) as config entities.
- Export reporting endpoint configuration (including type and external URI) with the rest of your site config for deployment.
- Roll out a CSP in report-only mode and watch violations accumulate before enforcing it.
- Detect mixed-content or blocked-resource issues surfaced as CSP violations.
- Debug which third-party script a CSP is blocking by reading the blocked-URI in the report.
- Feed logged reports into external log aggregation via Drupal's logging channel (`reporting`).
- Prove a CSP change reduced violations by comparing report volume before/after.
- Give security teams a Drupal-native place to inspect browser policy violations.
- Migrate an endpoint from internal to external (or back) by switching its type, keeping the same id.
- Keep report intake standards-compliant (correct 202/400/405/410/415 status codes, empty bodies).
