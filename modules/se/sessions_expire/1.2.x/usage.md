<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Disable automatic session GC and run it via cron/drush instead.

---

Session Expire disables sessions garbage collection and allows doing it via cron / a drush command — so the unpredictable, probabilistic session GC that PHP/Drupal runs during random requests is turned off and instead runs deterministically on cron or on demand, avoiding GC-induced latency spikes on user requests. Supports Drupal 9, 10, and 11.

---

- Disable automatic session GC.
- Run GC via cron.
- Run GC via a drush command.
- Avoid random GC latency.
- Make GC deterministic.
- Aid performance/ops.
- Support Drupal 9, 10, and 11.
- Configure the schedule.
- Aid session management.
- Handle session expiry.
- Clean sessions.
- Control GC
- Support Drupal.
- Support Drupal.
- Support Drupal.
