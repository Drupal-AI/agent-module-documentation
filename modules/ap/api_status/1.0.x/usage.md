<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
API Status is a tiny monitoring helper that records the last success/failure of any API call in Drupal's State API and shows it on a report dashboard.
---
Other code calls `ApiStatusService::log($api_key, 'success'|'failed', $endpoint)` after making an API request. The service stores the timestamp under `api_status.{status}.{api_key}`, optionally records the endpoint path, and maintains a list of tracked API keys in state. `getStatus()` returns the last success/failure times for an API, letting you see at a glance whether an integration is healthy.

The dashboard at `/admin/reports/api-status` (`access api status dashboard`) lists tracked APIs with their last success/failure and endpoint. There is no automatic instrumentation — you wire the `log()` calls into your own integration code. It has no outbound requests, no secrets and no writable public endpoints; the only route is the permission-gated report page.
---
- Record the last success of a named API integration.
- Record the last failure of an API integration.
- Store the endpoint path alongside a status.
- List all tracked APIs on a dashboard.
- See the last success/failure time per API.
- Check whether an integration is currently healthy.
- Instrument custom API client code with `log()` calls.
- Query `getStatus($api_key)` programmatically.
- Track many independent APIs by key.
- Use the State API so no schema/table is needed.
- Surface integration health under Reports.
- Grant a support role read access to the dashboard.
- Detect a silently failing third-party API.
- Add lightweight health signals without a full monitoring stack.
- Keep a running list of which APIs are in use.
- Restrict dashboard access with a dedicated permission.