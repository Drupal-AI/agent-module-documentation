An analytics dashboard for API Orchestrator request logs, with charts for traffic, latency timeline, endpoint performance and status-code distribution.

---

The Analytics submodule adds an admin dashboard at `/admin/config/services/api-orchestrator/analytics`. `AnalyticsDashboardController` exposes cache-disabled AJAX JSON endpoints (stats, timeline, endpoints, distribution, requests) that run parameterized aggregate SQL over the `api_orchestrator_request` table and feed a Chart.js-based SDC component. Users filter by service, endpoint, status, method, date range, duration and response code, and pick a time granularity (minute/hour/day/week/month) that maps to a whitelisted date-format pattern. The request list supports server-side pagination and whitelisted sort columns. Requires `api_orchestrator`.

---

- View total, completed and failed request counts over a chosen period.
- See a traffic-and-latency timeline at minute/hour/day/week/month granularity.
- Compare endpoint performance (volume, success rate, average duration).
- Inspect HTTP status-code distribution.
- Filter analytics by service, endpoint, status, method and response code.
- Restrict analytics to a date range or duration band.
- Browse a paginated, sortable list of individual requests.
- Drill from a request row to its detail page.
- Monitor average response duration and response size trends.
- Use live AJAX endpoints to build custom monitoring views.
