<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

API Response Check has two admin pages: one to enter the URLs you want to check,
and one to view the recorded results. Both require the **Administer site
configuration** permission.

## Enter the URLs to check

1. Log in as a user with the **Administer site configuration** permission.
2. Go to `/admin/config/api-response-check/adminsettings`.
3. Enter the API URLs you want to monitor. The list is stored in the module's
   configuration (the `api_inputs` setting).
4. Save the form. You can add or remove URLs here at any time.

## View the results

1. Go to `/admin/config/api-response-check/view-results`.
2. The page shows a table of the checked URLs with each one's HTTP response
   **status** and the **timestamp** of the check.
3. The table is **sortable** — click the *date* or *status* column headers to
   reorder — and **paged** at 50 rows per page.

## Keeping the log tidy

The module records results over time, so on a busy site the underlying results
table can grow. It is safe to remove old rows from the `api_response_check`
database table if it gets large. Treat this module as an internal monitoring log,
not a full uptime-monitoring service — pair the checks with cron or manual runs to
keep the recorded statuses current.
