Enables file-entity tracking for Events Log Track: file create/update/delete operations appear in the audit report with type `file`, capturing the file URI and name.

---

`EventLogTrackFileHooks` registers the `file` handler (operations insert/update/delete) and implements `hook_file_insert`, `hook_file_update`, and `hook_file_delete`. Each entry stores the file URI as the description, the file id in `ref_numeric`, and the filename in `ref_char`, then writes through the parent `event_log_track.manager` service. Note this tracks the managed-file entity lifecycle (which fires on uploads and file cleanup), inheriting filtering, retention, and the `access event log track` permission from the parent.

---

- Audit file uploads across the site.
- Record the storage URI of each managed file created.
- Track file replacements and updates.
- See when temporary or orphaned files are deleted.
- Filter the audit report to only `file` events.
- Trace a file's history by its id (`ref_numeric`).
- Investigate where a specific filename came from.
- Detect unexpected file deletions.
- Correlate uploads with the acting user and IP.
- Demonstrate accountability for uploaded assets.
- Prune old file-change records via cron retention.
- Exclude temp-file noise using skip patterns.
- Export a report of file activity over a period.
- Combine with media tracking for full asset auditing.
- Identify large numbers of files created by one account.
