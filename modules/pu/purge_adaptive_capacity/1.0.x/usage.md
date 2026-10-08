<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Purge Adaptive Capacity dynamically tunes how many purge items run per cron based on current load.

---

Purge Adaptive Capacity adapts the number of Purge queue items processed per cron run based on the current system load/capacity — so cache invalidation keeps up during busy periods without overwhelming the origin, tuning throughput dynamically instead of a fixed batch size.

Administration is gated by `administer purge adaptive capacity`. Depends on `purge`; supports Drupal 10.3+, 11, and 12.

---

- Adapt purge throughput per cron.
- Base capacity on current load.
- Keep cache invalidation timely.
- Avoid overwhelming the origin.
- Replace fixed batch sizes.
- Tune throughput dynamically.
- Gate admin with `administer purge adaptive capacity`.
- Depend on `purge`.
- Support Drupal 10.3+, 11, and 12.
- Improve purge performance.
- Handle busy periods.
- Manage queue processing.
- Support CDN purging
- Configure capacity
- Optimize invalidation.
- Scale purging.
- Balance load.
- Process purge items adaptively
