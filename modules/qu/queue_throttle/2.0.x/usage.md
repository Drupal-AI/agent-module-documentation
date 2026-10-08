<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Queue Throttle provides throttled queue processing consumption.

---

Queue Throttle provides **throttled queue processing** — rate-limiting how fast queue items are consumed,
so heavy queue work (e.g. API calls, notifications, indexing) doesn't overwhelm the server or a rate-limited
external service. It provides its own permissions.

Use it to pace queue consumption. It is an operations/automation feature; queue items run with the site's
privileges (as queue processing does), and it has no access-control role beyond its permission. Configure the
throttle limits.

---

- Throttle queue processing.
- Rate-limit item consumption.
- Avoid overwhelming the server.
- Respect rate-limited external services.
- Provide its own permissions.
- Pace queue work.
- Run items with site privileges.
- Have no access-control role beyond permission.
- Configure the throttle limits.
- Handle queue throttling.
- Throttle queues.
- Configure throttling.
- Pace processing.
- Handle the throttle.
- Limit consumption.
- Configure queues.
- Handle automation.
- Slow queues.
- Set the limits.
- Provide queue throttling.
