<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# api_response_check

Logs HTTP response status for admin-configured API URLs.

- Settings form at `/admin/config/api-response-check/adminsettings`; results at `.../view-results`. Both `administer site configuration`.
- `ApiResponseController::results()` reads table `api_response_check`, renders a sortable pager table.
- Config `api_inputs` = URL list. No anonymous routes; disclosure is admin-only.

See [../usage.md](../usage.md).
