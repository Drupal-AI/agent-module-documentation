MCP Tools - Cron adds Tool API plugins that let an MCP/AI connection run cron, process queue workers, and inspect and adjust cron settings on a Drupal site.

---

This submodule of MCP Tools contributes five `tool` plugins under the `cron` category: get cron status, run cron, run a named queue, update the cron autorun threshold, and reset the cron key. Each extends `McpToolsToolBase`, so access is enforced by the shared MCP Tools model — the `mcp_tools use cron` permission plus the connection's read/write/admin scope, the ops write-kind policy, and the global read-only switch — before the underlying `CronService` (wrapping core `@cron`, `@state`, `@queue`, and the queue-worker manager) is invoked. It has no routes, forms, or config of its own; enable it and grant the permission to the executor role.

---

- Ask an AI assistant when cron last ran and whether it is overdue.
- Trigger a full cron run on demand without shell access (`drush cron` equivalent).
- Drain a specific queue (e.g. a mail or index queue) by name, in bounded batches.
- Check how many items remain in a queue after a run and repeat until empty.
- Raise or lower the automated-cron autorun threshold from a conversation.
- Rotate the cron key when a `/cron/<key>` URL may have leaked.
- List which modules implement `hook_cron` on the site.
- Confirm cron health as part of a scripted site audit.
- Let an agent kick cron before running a report that depends on fresh data.
- Process a background queue during a controlled maintenance window.
- Verify `system.cron_last` advanced after a manual run.
- Diagnose "cron never runs" complaints by reading status and running it once.
- Tune autorun threshold to match a site's traffic pattern.
- Wire cron runs into an ECA or AI-agent workflow via the Tool API.
- Give a read-only MCP connection visibility into cron without write power.
- Run queue workers that a UI does not expose a button for.
- Reset the cron key as part of a security-response runbook.
- Expose cron operations to Claude Code / Cursor over the MCP transports.
- Batch-process a large queue in repeated bounded calls to avoid timeouts.
- Include cron status in an automated health-check summary.
