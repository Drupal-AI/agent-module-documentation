<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Integration Report (integration_report) — agent index

**Single admin page that runs and shows the availability status of third-party endpoints registered by other modules.**

- **Version:** 2.3.x
- **Core:** `^10 || ^11`
- **Routes (permission `access integration report`, restricted):** `/admin/reports/integrations` (overview), `/admin/reports/integrations/{report_class}` (JS callback).
- **Service:** `integration_report.report_manager` — `service_collector` for the `integration_report` tag.
- **Extend:** subclass `IntegrationReportBase`, tag the service `integration_report`; example in `modules/integration_report_example`.

**Security:** Both routes are gated by the restricted `access integration report` permission. `jsCallback` escapes the class name and resolves it only against already-registered tagged services (`findReport` via `str_contains` on short class names) — no arbitrary class instantiation. No mutating or anonymous endpoints.

See [api/integration_report.md](api/integration_report.md).
