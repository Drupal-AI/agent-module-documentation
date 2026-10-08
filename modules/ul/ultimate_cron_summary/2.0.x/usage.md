<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ultimate Cron Summary adds a compact cron-health overview dashboard on top of the Ultimate Cron jobs page.

---

Ultimate Cron Summary **adds a cron-health overview dashboard** to Ultimate Cron. It replaces the cron-job list
builder so that a compact summary of status tiles renders above the standard jobs table: each tile represents one job
state (error, warning, success, running, notice, disabled, missing, unfinished) and links straight to the newest
matching job's row. Tiles reuse Drupal's Site Status Report counter styling and lay out in a responsive three-column
grid. Jobs that were never run, disabled jobs, and jobs whose definition is missing all get their own icon so
misconfiguration is easy to spot. Administrators can hide chosen states from the dashboard via an **Exclude** setting
added to Ultimate Cron's general settings form, and contextual links cross-navigate between the dashboard and that
settings page. It is an admin-facing monitoring feature — it depends on the Service and Ultimate Cron modules,
requires Drupal core `>=11.2` and PHP `>=8.5`, and defines no permissions or routes of its own (the dashboard and
settings inherit Ultimate Cron's access).

---

- Show a cron-health dashboard above the Ultimate Cron jobs table.
- Assess cron jobs at a glance via status tiles.
- Jump from a tile to the newest matching job row.
- See one tile per job state (error, warning, success, running, notice, disabled, missing, unfinished).
- Spot jobs that have never been run.
- Spot disabled jobs by their dedicated icon.
- Spot jobs whose definition is missing.
- Hide chosen statuses from the dashboard (Exclude setting).
- Configure exclusions at the Ultimate Cron settings form.
- Store excluded statuses in `ultimate_cron_summary.settings:exclude`.
- Cross-navigate between dashboard and settings via contextual links.
- Serve administration/monitoring only.
- Aggregate cron status admin-facing.
- Gate the dashboard to admins (inherits Ultimate Cron access).
- Read the module's help page for a feature overview.
- Reuse Site Status Report counter styling.
- Lay out tiles in a responsive three-column grid.
- Monitor cron health across dozens or hundreds of jobs.
- Reduce time spent scanning the full jobs table.
- View the cron summary.
