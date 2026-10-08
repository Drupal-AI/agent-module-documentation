Applies configurable retention, archiving and deletion policies to file and media entities automatically via cron and the Queue API, with legal hold, an audit log and per-policy webhooks.

---

The Lifecycle Manager is a sub-module of Advanced Filesystem that lets administrators define lifecycle policies for files and media. Each policy matches entities by conditions (type, bundle, MIME type, size, age, metadata presence, referencing entity, current status) and applies actions on a schedule: archive an aged file to another stream wrapper, delete it (soft or hard), strip its metadata, restore it, or notify a set of roles. Policies are evaluated in priority order on cron (optionally restricted to specific days and an hour window), from an on-demand Run form, or through Drush, and matching entities are processed through a queue so large sites stay responsive. A global dry-run mode simulates without changing anything. Files can be placed on legal hold to exempt them from every policy, every applied action is recorded in an audit log, and a per-policy webhook can notify an external system whenever an action fires. Administration is gated behind the restricted "administer file lifecycle policies" permission.

---

- Automatically delete temporary or aged files after a configured number of days, hours or minutes.
- Archive old files to a different stream wrapper (e.g. move from public to a cold-storage scheme).
- Move archived files into a configurable subdirectory of the target scheme.
- Soft-delete files (mark as deleted) instead of hard-deleting them from disk.
- Optionally also delete the Media entities that reference an expired file.
- Strip EXIF/IPTC/XMP metadata fields from a file when it is archived.
- Restore a previously archived file back to its original URI.
- Notify chosen roles by e-mail when a file is archived or deleted.
- Match files by entity type, bundle, MIME type and minimum/maximum size.
- Match files by minimum age using a chosen date field and minutes/hours/days unit.
- Match only files that carry (or lack) EXIF metadata.
- Match files by whether they are referenced by a given entity type, bundle or field.
- Order multiple overlapping policies by priority so the most important wins.
- Detect conflicts between policies before they run.
- Run all enabled policies automatically on cron, capped by a per-run file limit.
- Restrict a policy to specific weekdays and a specific hour of the day.
- Trigger an evaluation on demand from the Run Lifecycle Evaluation form.
- Simulate any run with global dry-run mode to preview what would happen.
- Drive evaluation from Drush: `drush lifecycle:run`, `lifecycle:status`, `lifecycle:queue-size`, `lifecycle:reset-stats`.
- Place a file on legal hold so it is skipped by all lifecycle policies.
- Review every applied action in the lifecycle audit log, filtered by file or policy.
- Clear the audit log or prune it by age.
- Track when private files were last downloaded via the adfs_last_accessed field.
- POST a webhook to an external system each time a lifecycle action is applied.
- Bulk-set a file's lifecycle status with the "Set lifecycle status" action (Views Bulk Operations).
