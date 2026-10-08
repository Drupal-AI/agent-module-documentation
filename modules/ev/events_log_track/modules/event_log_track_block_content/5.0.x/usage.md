Enables custom-block (block content) tracking for Events Log Track: create/update/delete of content blocks appears in the audit report with type `block_content`.

---

`EventLogTrackBlockContentHooks` registers the `block_content` handler (operations insert/update/delete) and implements the three `block_content` entity hooks. Each entry records the block bundle, label, and published status in the description, the block id in `ref_numeric`, and the label in `ref_char`, then writes through the parent `event_log_track.manager` service. Filtering, retention, and the `access event log track` permission come from the parent.

---

- Audit creation of reusable custom blocks.
- Track edits to block content and their published state.
- See who deleted a custom block.
- Filter the audit report to only `block_content` events.
- Distinguish block insert vs update vs delete.
- Trace a block's change history by its id (`ref_numeric`).
- Record which content editor changed a promotional block.
- Detect accidental or unauthorized block deletions.
- Demonstrate accountability for reusable content.
- Correlate block changes with the acting user and IP.
- Prune old block-change records via cron retention.
- Exclude specific block labels with skip patterns.
- Export a report of block edits over a period.
- Combine with Layout Builder auditing workflows.
- Identify blocks published then quickly unpublished.
