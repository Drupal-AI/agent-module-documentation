MCP Tools - Ultimate Cron lets an MCP/AI connection list, inspect, log, enable, disable, and run individual Ultimate Cron jobs on a Drupal site.

---

This submodule of MCP Tools integrates with the contrib Ultimate Cron module via six `tool` plugins under the `ultimate_cron` category. Three are read tools (list jobs, get one job, read a job's recent logs) and three are write tools (enable, disable, run a job). They operate on `ultimate_cron_job` config entities through `UltimateCronService`, which uses the entity storage, the database (for logs), and the logger factory. Access is enforced by the shared MCP Tools model — the `mcp_tools use ultimate_cron` permission plus the connection scope, the ops write-kind policy, and the read-only switch — with write tools re-checking write access in `executeLegacy()`. Requires the Ultimate Cron module.

---

- Ask an AI which cron jobs are registered and their last run status.
- Read the recent execution log of a job that keeps failing.
- Run a single slow job on demand instead of a full cron pass.
- Disable a misbehaving job while you investigate it.
- Re-enable a job after a fix is deployed.
- Inspect one job's schedule and configuration by machine name.
- Triage cron problems per-job rather than site-wide.
- Get a quick health overview of all scheduled jobs.
- Kick a specific import/index job before a demo.
- Pause a heavy job during a traffic spike, then resume it.
- Check whether a job actually ran by reading its logs.
- Integrate per-job cron control into an ECA or AI-agent workflow.
- Diagnose "one job never runs" without opening the admin UI.
- Confirm a job is enabled before relying on its output.
- Run a maintenance job as part of a scripted runbook.
- Compare last-run times across jobs to spot stalls.
- Drive Ultimate Cron from Claude Code / Cursor over MCP.
- Read logs to correlate a job with an error spike.
- Temporarily disable a job that conflicts with a migration.
