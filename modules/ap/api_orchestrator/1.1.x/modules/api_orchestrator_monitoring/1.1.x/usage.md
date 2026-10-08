A real-time monitoring dashboard for API Orchestrator, with live metrics, a day/hour activity heatmap and a live request feed.

---

The Monitoring submodule adds a real-time dashboard at `/admin/config/services/api-orchestrator/monitoring`. `MonitoringController` exposes cache-disabled AJAX JSON endpoints for realtime metrics, an activity heatmap (by day of week and hour), and a live recent-request feed that polls for new rows. All metrics come from parameterized aggregate SQL over the `api_orchestrator_request` table and render into a Chart.js/SDC component with polling JavaScript. Requires `api_orchestrator`.

---

- Watch request throughput and success/failure counts update in near real time.
- Spot busy periods with a day-of-week × hour activity heatmap.
- Choose the heatmap metric (request count or average duration).
- Follow a live feed of the most recent requests as they complete.
- Set the heatmap window in days.
- Cursor-page the live feed by last-seen request id to fetch only new rows.
- Monitor error rates and average latency for the current window.
- Keep an ops screen open on the monitoring page during deployments or incidents.
