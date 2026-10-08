<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# integration_report — implementing a report

1. Create a class extending `Drupal\integration_report\IntegrationReportBase` (implements `IntegrationReportInterface`).
2. Implement the request/status methods (see `integration_report.api.php`): `getName()`, `getDescription()`, `menuCallback()` (returns the live check output), and optionally `getJs()`, `isUseCallback()`, `isSecureCallback()`, `statusPage()`, `access()`.
3. Register it as a service and tag it:

```yaml
services:
  mymodule.integration_report:
    class: Drupal\mymodule\MyIntegrationReport
    tags:
      - { name: integration_report }
```

The `integration_report.report_manager` collector calls `addReport()` for each tagged service (priority-sortable). At `/admin/reports/integrations` the overview lists every report whose `access()` returns TRUE; each row's result is loaded by JS calling `/admin/reports/integrations/{shortClassName}` → `jsCallback()` → your `menuCallback()`.

Use `isUseCallback()` + an `<iframe>` for integrations that redirect (e.g. SSO), and `isSecureCallback()` to force HTTPS on the iframe URL. Grant the `access integration report` permission to roles that should see the page.
