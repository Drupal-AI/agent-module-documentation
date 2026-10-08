<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
- What: validates a set of configured API URLs by checking their HTTP response and records the status.
- When: you want a lightweight admin log of whether external/internal API endpoints are responding.

---

- Enable the module; it stores checked URLs in config key `api_inputs`.
- Enter URLs at `/admin/config/api-response-check/adminsettings` (route `api_response_check.admin_settings_form`, `administer site configuration`).

---

- Results are shown at `/admin/config/api-response-check/view-results` (`administer site configuration`).
- Controller `ApiResponseController::results()` queries the `api_response_check` table for wid/status/timestamp/api_url.
- Results render in a sortable, pager-limited (50/page) `#type: table`.
- Both routes require `administer site configuration`, so no anonymous disclosure of the log.
- Config `api_inputs` holds the list of URLs to validate.
- Use it to keep a historical record of endpoint availability.
- The stored `api_url` and `status` are displayed to admins for triage.
- Forms `ApiInputForm` (settings) and `ApiResponseForm` (on the results page) drive the workflow.
- The results table auto-escapes values through the render array.
- Add or remove URLs any time via the settings form.
- Sort by date or status using the table header links.
- No public-facing routes are exposed.
- Pair with cron or manual checks to refresh the logged statuses.
- Use for internal monitoring dashboards, not as a full uptime service.
- Clear old rows from the `api_response_check` table if it grows large.
- Version 2.0.x supports Drupal 8/9/10.
