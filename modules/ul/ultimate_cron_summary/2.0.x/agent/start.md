<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ultimate Cron Summary — agent index

**Extends Ultimate Cron with a compact cron-health overview dashboard** rendered above the cron jobs table.
Depends on `service` (`>=2.1`), `ultimate_cron`. Version **2.0.0**. Core `>=11.2`, PHP `>=8.5`.

Admin-facing monitoring only. Defines **no routes, permissions, or Drush commands** of its own; the dashboard and
settings inherit Ultimate Cron's access. It overrides the `ultimate_cron_job` entity list builder to inject status
tiles, and adds an **Exclude** field to Ultimate Cron's general settings form.

- **View the dashboard**: visit the Ultimate Cron jobs page (`entity.ultimate_cron_job.collection`); tiles show one
  per job state and link to the newest matching row.
- **Hide statuses from the dashboard** → [configure/ultimate_cron_summary.md](configure/ultimate_cron_summary.md)
