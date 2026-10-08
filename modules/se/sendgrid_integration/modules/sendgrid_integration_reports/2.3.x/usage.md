SendGrid Integration Reports adds an admin dashboard that pulls email statistics (volume, opens, clicks, bounces, spam, browser/device breakdowns) from the SendGrid v3 stats API, using the API key configured in the parent SendGrid Integration module.

---

This submodule of SendGrid Integration provides a reports dashboard at **Admin → Reports → SendGrid** (`admin/reports/sendgrid`). Its `Api` service (`sendgrid_integration_reports.api`) authenticates to `https://api.sendgrid.com/v3/` with the API key resolved from `sendgrid_integration.settings` (via the Key module when present) and calls Guzzle against SendGrid stat endpoints: global `stats`, `categories/stats`, `browsers/stats`, `devices/stats`, `suppression/bounces`, and `subusers`. The controller renders global sending volume and spam charts (Google Charts via the `googlejsapi` and `main` libraries) plus browser and device tables. Because the stat calls can be large, results are cached in a dedicated `sendgrid_integration_reports` cache bin (declared as a `cache.bin` service so you can point it at Redis/Memcache), keyed per report; changing the settings form clears the whole bin. The settings form (`admin/config/services/sendgrid/reports`) stores a date range and aggregation window (`start_date`, `end_date`, `aggregated_by` = day/week/month) in `sendgrid_integration_reports.settings`, defaulting to the last 30 days aggregated by day. It requires the parent module and its API key; without a key the service logs a warning and returns empty data.

---

- View a dashboard of SendGrid email statistics inside Drupal at `admin/reports/sendgrid`.
- See global sending volume (opens, clicks, delivered) as a chart over a date range.
- Monitor spam reports and spam-report drops over time.
- Review click counts broken down by browser.
- Review open counts broken down by device type.
- Pull bounce data per subuser from SendGrid's suppression/bounces endpoint.
- Enumerate SendGrid subusers via the API for multi-account reporting.
- Fetch category-scoped stats (`categories/stats`) for a specific set of SendGrid categories.
- Configure the reporting date range (start/end date) from the settings form.
- Choose aggregation granularity: day, week, or month.
- Default reporting to the trailing 30 days without any configuration.
- Cache SendGrid API responses to avoid a service call on every page load.
- Point the reports cache bin at an alternate backend (Redis, Memcache, MongoDB) via the `cache.sendgrid_integration_reports` service.
- Clear cached report data automatically whenever report settings change.
- Reuse the parent module's configured API key (including a Key-module-managed key) for reporting.
- Restrict who can change report settings with the `administer sendgrid integration reports` permission.
- Expose the dashboard to users with `access site reports`.
- Call the `sendgrid_integration_reports.api` service from custom code to fetch stats arrays.
- Report on a specific SendGrid subuser by passing an `on-behalf-of` username to the API service.
- Build custom SendGrid analytics pages on top of the cached stats data.
- Get an at-a-glance deliverability health check (bounces, invalid emails, blocks) via the global stats.
