Enables node CUD tracking for Events Log Track: enabling this submodule makes every node create, update, and delete appear in the audit report at `admin/reports/events-track` with type `node`.

---

`EventLogTrackNodeHooks` registers the `node` handler (operations insert/update/delete) and implements `hook_node_insert`, `hook_node_update`, and `hook_node_delete`. Each records the node's content type, title, and published status in the description, stores the node id in `ref_numeric` and the title in `ref_char`, and passes the entry to the parent `event_log_track.manager` service, which fills actor/IP/path/time and writes the row. A Views relationship (`elt_node_join`) lets reports join the logged node back to `node_field_data`. All configuration, retention, filtering, and the `access event log track` permission are inherited from the parent module.

---

- Audit every node creation with author, timestamp, and IP.
- See who updated a specific page or article and when.
- Track who unpublished or deleted content.
- Record the published/unpublished status at the moment of each change.
- Filter the audit report to only `node` events.
- Filter node events by operation (insert vs update vs delete).
- Trace the full change history of a node by its id (`ref_numeric`).
- Detect mass content deletions by an account.
- Build a Views report joining node events to the node title/type.
- Demonstrate editorial accountability for compliance.
- Combine with the workflows submodule to also capture moderation transitions.
- Prune old node-change records automatically via the parent's cron retention.
- Exclude specific node titles from logging using the parent's skip patterns.
- Export a per-user list of content changes over a date range.
- Correlate content changes with the acting user's IP address.
