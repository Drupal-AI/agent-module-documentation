<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Scheduler Request Cron allows running Scheduler's lightweight cron as part of page requests.

---

Scheduler Request Cron runs the Scheduler module's lightweight cron during normal page requests — so
scheduled publish/unpublish actions are processed promptly (on request traffic) rather than waiting for the
next full cron run, improving timeliness of scheduled content. It is configured at
`scheduler_request_cron.settings`, in the Custom package.

Use it to make Scheduler act more promptly without frequent full cron. It is an automation feature triggering
Scheduler's lightweight cron on requests; the scheduled actions run with the site's privileges (as cron
does), and it has no access-control role. Note it adds a small amount of work to page requests (the
lightweight cron) — configure the frequency sensibly. Configure the request-cron behaviour.

---

- Run Scheduler's cron on page requests.
- Process scheduled publish/unpublish promptly.
- Avoid waiting for full cron.
- Configure at scheduler_request_cron.settings.
- Improve scheduled-content timeliness.
- Trigger lightweight cron on requests.
- Run actions with site privileges.
- Have no access-control role.
- Add small work to requests.
- Configure the frequency sensibly.
- Handle request-based cron.
- Process scheduling promptly.
- Run Scheduler lightweight cron.
- Configure the behaviour.
- Trigger on requests.
- Handle scheduled actions.
- Process scheduling.
- Run on requests.
- Configure request cron.
- Improve scheduling.
