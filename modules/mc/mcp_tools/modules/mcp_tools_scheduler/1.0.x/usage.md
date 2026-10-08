MCP Tools - Scheduler lets an MCP/AI connection schedule content to publish or unpublish at a chosen date/time via the Drupal Scheduler module, and inspect or cancel those schedules.

---

This submodule of MCP Tools bridges to the contrib Scheduler module with five `tool` plugins under the `scheduler` category: list scheduled content, get one entity's schedule, schedule a publish, schedule an unpublish, and cancel a schedule. The plugins set Scheduler's `publish_on`/`unpublish_on` fields through `SchedulerService`; Scheduler's own cron performs the eventual state change. Access follows the shared MCP Tools model — the `mcp_tools use scheduler` permission plus the connection scope (read for the two get tools, write for the three mutating tools), the content write-kind policy, and the read-only switch — with an extra `canWrite()` guard in the service. It requires the Scheduler module and its date fields on the target bundle.

---

- Tell an AI to publish an article next Monday at 09:00.
- Schedule a promotion page to unpublish automatically when the sale ends.
- List everything queued to publish in the coming week.
- List content set to unpublish so an editor can review it.
- Look up the exact publish/unpublish times set on a specific node.
- Cancel a scheduled publish that was set by mistake.
- Cancel only the unpublish half of a schedule while keeping the publish.
- Bulk-plan an editorial calendar through conversational commands.
- Move a launch time by cancelling and re-scheduling.
- Coordinate embargoed content release without manual field editing.
- Let a read-only connection audit upcoming scheduled changes.
- Integrate scheduling into an ECA or AI-agent content workflow.
- Schedule seasonal banners to appear and disappear on set dates.
- Confirm a schedule "stuck" because Scheduler cron has not yet run.
- Automate time-boxed publication of event pages.
- Set an unpublish date on time-sensitive notices.
- Drive Scheduler from Claude Code / Cursor over MCP without the admin UI.
- Verify a bundle actually has the `publish_on`/`unpublish_on` fields before scheduling.
- Clear all schedules on an entity before archiving it.
