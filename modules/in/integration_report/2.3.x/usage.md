<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Integration Report provides a single admin page that checks and displays the availability of third-party API endpoints your site integrates with.
---
The problem it solves: sites often depend on several external services (payment, CRM, SSO, search) with no single place to confirm they are reachable. Integration Report collects status checks contributed by any module and renders them together at `/admin/reports/integrations`, so an admin can see all integration health in one view — including iframe-based checks useful for SSO flows that redirect.

How it works: the `integration_report.report_manager` service is a `service_collector` that gathers every service tagged `integration_report` (each an `IntegrationReport` subclass). The overview controller builds a table, one row per report, and each report's live result is fetched asynchronously by JavaScript hitting `/admin/reports/integrations/{report_class}` (`jsCallback`), which looks up the report by its short class name and returns `menuCallback()` output. Reports can optionally run through an `<iframe>` (for redirect-based SSO debugging) and attach their own JS. Both routes require the restricted `access integration report` permission. Report class names are escaped and resolved only against registered, tagged services, so no arbitrary class is instantiated.

Setup: this module is a framework — install it, then in a custom module extend `IntegrationReportBase` (see `integration_report.api.php` and the bundled `integration_report_example` submodule), register the class as a service tagged `integration_report`, and grant `access integration report` to the appropriate role.
---
- View the availability of all registered integrations on one page.
- Add a custom status check by extending `IntegrationReportBase`.
- Register a report as a service tagged `integration_report`.
- Run an iframe-based check for redirect/SSO integrations.
- Fetch each report's status asynchronously without blocking page load.
- Return arbitrary markup from a report's `menuCallback()`.
- Attach report-specific JavaScript to the status page.
- Provide status info on behalf of a module that lacks its own report page.
- Order reports by priority via the service collector.
- Gate the report page behind the restricted `access integration report` permission.
- Debug content responses inline under the status table.
- Use the example submodule as a copy-paste starting point.
- Give each integration a name and description shown in the table.
- Distinguish secure vs non-secure callback URLs per report.
- Centralise third-party endpoint monitoring for ops teams.
- Surface amber/green status states per integration.
