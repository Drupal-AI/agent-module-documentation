<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Driplet Log streams Drupal's log messages to an admin report page in real time over Driplet's WebSocket channel.

---

`driplet_log` is a Driplet example submodule. It registers a PSR-3 logger (`DripletLogger`, tagged
`logger`) that, for every Drupal log entry, builds a Driplet message on the `driplet-log` topic
targeted at the `administrator` role and sends it through `driplet.service` (it skips its own
`driplet_log` / `driplet_notify` channels to avoid loops). It also adds an admin report page at
`/admin/reports/driplet-log` (`access site reports`) that renders an empty log table and attaches
`js/driplet-log.js`; that script subscribes to `driplet-log` over the Driplet WebSocket and prepends
a new row per incoming message (severity, type, date, message, uid), capped at 50 rows. Requires
`driplet` and core `dblog`.

---

- Watch Drupal log entries appear live without reloading `/admin/reports/dblog`.
- Give administrators a real-time tail of site errors and notices.
- See severity, channel/type, timestamp, message, and uid for each entry as it happens.
- Follow a live view while reproducing a bug in another tab.
- Monitor a deployment or cron run in real time.
- Learn how to implement a Driplet logger backend from a worked example.
- Route log visibility to the administrator role only via message targeting.
- Keep the on-screen buffer bounded (latest 50 entries).
- Combine with the base module's per-role/per-uid targeting for custom log dashboards.
- Use it as a template for streaming any event stream to a Drupal report page.
- Confirm the Driplet microservice + WebSocket path is working end to end.
- Avoid feedback loops by excluding Driplet's own log channels.
