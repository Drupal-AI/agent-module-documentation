<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Status (api_status) — agent index

**Records last success/failure of API calls in the State API and displays them on a report dashboard.**

- **Version:** 1.0.x (1.0.0)  •  **Core:** ^9 || ^10 || ^11  •  **Package:** Monitoring
- **Route:** `api_status.dashboard` `/admin/reports/api-status` (`access api status dashboard`).
- **Service:** `api_status.tracker` → `ApiStatusService` (`log()`, `getStatus()`).  **Storage:** State API keys `api_status.*`.
- **Permission:** `access api status dashboard`.

**Security:** single read-only report route behind its permission; no outbound calls, no secrets, no mutating public endpoints. Instrumentation is opt-in from your own code. See [api/service.md](api/service.md).
