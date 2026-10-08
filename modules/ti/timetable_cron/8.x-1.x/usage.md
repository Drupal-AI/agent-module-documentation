<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Timetable Cron replaces the core `cron` service with a subclass so that each `hook_cron` implementation can be given its own unix-crontab-style schedule (minute/hour/day/month/weekday), stored as `timetable_cron` config entities, with a force-run action and a per-job last-run/status list.

---

Core cron is one queue on one schedule: every registered `hook_cron` runs whenever cron runs, and the only lever is how often cron fires. Real sites often want more shape — a nightly import that must not run during business hours, a cache warm that should only fire in the early morning, a heavy report that belongs on the weekend. Without something like this the usual workaround is several system crontab entries hitting different Drush commands, which moves the schedule out of Drupal and out of configuration.

Timetable Cron takes a different route. Its `TimetableCronServiceProvider` alters the container's `cron` service definition to use `Drupal\timetable_cron\TimetableCron`, a subclass of `Drupal\Core\Cron` that overrides `invokeCronHandlers()`. On each cron run it reads the current minute/hour/day/month/weekday, then for every known job compares those against the job's stored fields (with `*` meaning "any" and `*/N` interval support on minute and hour) and skips any job whose time does not match. The first time it sees a `hook_cron` implementation it auto-creates a matching config entity defaulting to `* * * * *` (run every time), so the schedule table fills itself in after the first cron run. Because the standard service is swapped out, this module is mutually exclusive with other cron managers such as Elysia Cron or Ultimate Cron — run only one.

Each schedule is a `timetable_cron` configuration entity (add/edit/delete forms plus a **force** action) listed at `/admin/config/system/timetable_cron`. Being config entities, schedules export and deploy with the rest of the site's configuration, so a schedule change is reviewable in a diff and identical across environments — the main reason to prefer this over crontab entries that live only on one server. Per-job last-run timestamps and the pending force flag are kept in Drupal state (`timetable_cron.runtime`), not in exported config. The force action queues a single next-run for one job; the actual work still happens on the next normal cron invocation. Everything is gated behind the `configure timetable_cron` permission.

---

- Run a specific cron task only overnight.
- Keep a heavy job out of business hours.
- Schedule a weekly job separately from hourly ones.
- Give each `hook_cron` implementation its own timetable.
- Run a job every 10, 20 or 30 minutes with a `*/N` minute interval.
- Run a job only on a chosen weekday.
- Disable a single cron task without disabling its module.
- Force one scheduled job to run on the next cron.
- Export cron schedules with site configuration.
- Keep schedules identical across environments.
- Review a schedule change in a config diff.
- Replace several server crontab entries with in-Drupal schedules.
- Delay a job until after a nightly import window.
- Stop a report from competing with peak traffic.
- List every scheduled job with its last-run time in one place.
- Diagnose a job that did not run at the expected time.
- Set up multiple schedules for the same job by copying an entry.
- Retire a schedule without touching the server.
- Stage a schedule change through a deployment pipeline.
- Restrict who can change or force cron schedules to trusted admins.
