<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Reporting implements the W3C Reporting API in Drupal: it defines "reporting endpoint" config entities, advertises them to browsers via a `Reporting-Endpoints` response header, and logs the violation/deprecation/CSP reports browsers POST back to those endpoints.

---

The module lets a Drupal site act as the collector for browser-generated reports (CSP violations, deprecation warnings, network errors, crash reports, etc.). You create one or more **Reporting Endpoint** config entities (`reporting_endpoint`, managed at `/admin/config/system/reporting`). A response subscriber adds a `Reporting-Endpoints` header listing every enabled endpoint's absolute URL (`/system/reporting/{id}`), using structured-field serialization (the `gapple/structured-fields` library). Browsers then POST reports to that URL; the `ReportingEndpoint::log` controller accepts `application/reports+json` (Reporting API) and `application/csp-report` (legacy CSP `report-uri`, including Firefox's variant which it normalizes), validates them, and writes each report to Drupal's logger (`reporting` channel) as pretty-printed JSON. Endpoints can be disabled (the endpoint URL then returns `410 Gone`). If `dblog` is on, a "Recent violation reports" report at `/admin/reports/reporting` renders the logged entries in a table. The module also ships a `csp` integration plugin (`ReportTo`) so the Content-Security-Policy module can point its `report-uri`/`report-to` directives at a chosen reporting endpoint. Admin routes require `administer site configuration`; the report page requires `access site reports`; the collection endpoint itself is public (browsers post without authentication, by design).

---

- Collect Content-Security-Policy violation reports from visitors' browsers into Drupal's log.
- Provide a `report-uri`/`report-to` target for the Content-Security-Policy (`csp`) module via the bundled ReportTo plugin.
- Advertise reporting endpoints to browsers with a standards-based `Reporting-Endpoints` header.
- Capture browser **deprecation reports** to learn which deprecated web features your site still uses.
- Gather **intervention reports** (features the browser blocked, e.g. autoplay) for debugging.
- Log **network error logging (NEL)**-style and crash reports posted by browsers.
- Run a first-party CSP report collector instead of relying on a third-party SaaS like report-uri.com.
- Review recent violation reports in the admin UI at `/admin/reports/reporting` (with dblog enabled).
- Normalize Firefox's non-standard `csp-report` payload into the Reporting API format automatically.
- Temporarily disable an endpoint (returns 410 Gone) without deleting its configuration.
- Maintain multiple named endpoints (e.g. one for CSP, one for deprecations) as config entities.
- Export reporting endpoint configuration with the rest of your site config for deployment.
- Roll out a CSP in report-only mode and watch violations accumulate before enforcing it.
- Detect mixed-content or blocked-resource issues surfaced as CSP violations.
- Debug which third-party script a CSP is blocking by reading the blocked-URI in the report.
- Feed logged reports into external log aggregation via Drupal's logging channel (`reporting`).
- Prove a CSP change reduced violations by comparing report volume before/after.
- Give security teams a Drupal-native place to inspect browser policy violations.
- Point several sites' browsers at one Drupal collector endpoint per environment.
- Keep report intake standards-compliant (correct 202/400/405/410/415 status codes, empty bodies).
