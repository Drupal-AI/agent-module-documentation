Cron Service UI adds an admin page listing every registered Cron Service job with its schedule and a "force on next cron run" action.

---

Cron Service UI is the optional user-interface submodule of Cron Service Manager. Enabling it adds an overview page at `/admin/config/system/cron/services`, exposed as a local task ("Services") next to the core Cron settings under Administration → Configuration → System → Cron. The page renders a table (built by `ServiceListBuilder`) of every service registered with the `cron_service` tag: the service id (machine name, shown as plain text), a human-readable schedule column ("Scheduled for …", "Will be executed at next Cron run", or "Forced for the next Cron run" plus the previously scheduled time), a note when a job also implements `TimeControllingCronServiceInterface` (so it may still self-veto until forced), and an Operations column with a single "Force on next Cron run" link. That link opens a confirm form (`ForceServiceForm`) which, on confirmation, calls `CronServiceManager::forceNextExecution()` — the job is not run immediately but bypasses its schedule checks on the next cron run. Both the overview and the force form require the `access cron service ui` permission (declared with `restrict access: true`, so it is treated as a security-sensitive admin permission). The submodule adds no config, no entities and no schema; it only reads and displays state from the parent module's manager.

---

- View all registered cron services and their next scheduled run in one admin table.
- See at a glance which jobs are due "at next cron run" vs. scheduled for a future time.
- Force a specific cron job to run on the next cron run without waiting for its schedule.
- Confirm a force action through a proper confirm form before it takes effect.
- Identify jobs that implement their own `shouldRunNow()` gate (flagged in the schedule column).
- Give site administrators visibility into cron scheduling without reading code or State values.
- Grant the `access cron service ui` permission to a trusted admin role to delegate cron-job management.
- Reach the page as a local task alongside the core Cron settings ("Services" tab).
- Check whether a job is already forced for the next run (shown as "Forced for the next Cron run").
- See the previously scheduled time of a job that has since been forced.
- Manually trigger a stuck or time-gated job's next execution during debugging.
- Provide a lightweight operations dashboard for cron jobs on a site using Cron Service Manager.
- Verify that a newly added `cron_service`-tagged service was collected and is listed.
- Restrict cron-job management to specific roles by controlling the single UI permission.
- Cancel a force action safely via the confirm form's cancel link back to the overview.
