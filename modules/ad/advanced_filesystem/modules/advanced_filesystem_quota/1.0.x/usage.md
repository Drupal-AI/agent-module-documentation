Enforces per-user, per-role and per-bundle file storage quotas on upload, with a usage dashboard, a per-user file-management page and near-limit email alerts.

---

Advanced Filesystem: Quota Manager (machine name `advanced_filesystem_quota`) caps how much file storage each user may consume. Administrators define quota rules — scoped to a specific user, a role, or an entity-type/bundle — each with a byte limit, a weight and an optional block/warn action. When a file is uploaded, a `QuotaFileValidator` subscriber to the core `FileValidationEvent` asks `QuotaManager` for the effective limit (uid rules beat role rules beat bundle rules; the lowest limit wins), compares it against the user's current permanent-file usage (summed from `file_managed`), and either blocks the upload with a violation or shows a warning. A dashboard renders every rule with usage progress bars, a "My Files" page lets a user (or an admin) review and delete their own files to free space, and cron emails users approaching their limit. It depends on `file`, `user` and the parent `advanced_filesystem` module, ships config schema, and reuses the parent's `administer advanced_filesystem` permission for its admin routes.

---

- Give every authenticated user a 500 MB upload allowance via a per-role quota rule.
- Grant a specific power user a larger personal quota with a per-uid rule that overrides their role.
- Apply the most restrictive limit automatically when a user matches several role rules.
- Scope a quota to a content type (e.g. limit total storage of files attached to "article" nodes).
- Block uploads that would push a user over their limit, with a clear "quota exceeded" message.
- Warn-but-allow instead of blocking, by setting a rule's action (or the global default) to "warn".
- Exempt the site super-admin (uid 1) from all quotas with the `uid1_bypass` toggle.
- Leave anonymous uploads (uid 0) unaffected by quota rules.
- Show administrators a storage dashboard with per-rule usage bars (blue / orange ≥70% / red ≥90%).
- Let users self-manage storage on `/user/{user}/my-files`: see usage, list files, delete to reclaim space.
- Warn a user on the My Files page when a file they want to delete is still referenced by content.
- Let admins open any user's file list from the dashboard's per-uid "Files" link.
- Email users automatically when they cross a usage threshold (default 80%) via cron.
- Throttle those near-limit emails to at most one per user per interval (default 24h) using State.
- Preview which users would be notified with a dry-run of `QuotaManager::sendNearLimitAlerts()`.
- Turn quota enforcement on or off globally without deleting rules (the `enabled` setting).
- Track total storage consumed by a role or bundle across all its users for capacity planning.
- Add, edit and delete quota rules through dedicated admin forms with confirmation on delete.
- Enforce quotas through the modern constraint-based upload path (Drupal 10.3+ FileValidationEvent).
- Free quota space by permanently deleting owned files from a confirmation form (owner-verified).
