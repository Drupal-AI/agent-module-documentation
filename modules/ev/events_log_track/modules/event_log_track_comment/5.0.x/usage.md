Enables comment tracking for Events Log Track: comment create/update/delete operations appear in the audit report with type `comment`.

---

`EventLogTrackCommentHooks` registers the `comment` handler (operations insert/update/delete) and implements `hook_comment_insert`, `hook_comment_update`, and `hook_comment_delete`. Each entry records the comment type and subject in the description, the comment id in `ref_numeric`, and the subject in `ref_char`, then hands off to the parent `event_log_track.manager` service. Filtering, retention, and the `access event log track` permission are inherited from the parent.

---

- Audit who posted, edited, or deleted comments.
- Track comment moderation actions by editors.
- See the subject line of each affected comment.
- Filter the audit report to only `comment` events.
- Distinguish comment insert vs update vs delete.
- Trace a comment's history by its id (`ref_numeric`).
- Detect bulk comment deletions.
- Investigate spam cleanup activity.
- Correlate comment changes with the acting user and IP.
- Demonstrate moderation accountability.
- Prune old comment records automatically via cron retention.
- Exclude specific comment subjects with skip patterns.
- Export a report of comment activity over a period.
- Combine with node tracking to see comments alongside their content.
- Identify unusually high comment-deletion activity by an account.
