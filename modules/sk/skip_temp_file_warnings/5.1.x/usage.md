<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Skip Temp File Warnings helps skip the temporary file warning by deleting stale temporary file entries on cron run.

---

Skip Temp File Warnings addresses Drupal's status-report warning about temporary managed-file entries —
by deleting stale temporary file entries on cron, so the warning (which appears when temporary files
accumulate) is cleared. Temporary files are managed files not yet made permanent; core cleans them after a
period, but this module cleans up the entries to avoid the persistent warning. It is configured via
`system.logging_settings` and is in the System package.

Use it where the temporary-files status warning is a nuisance. It is an administration/maintenance tool that
removes stale temporary-file records; note it deletes temporary file entries, so ensure that behaviour is
appropriate for your workflow (files legitimately mid-workflow shouldn't be prematurely removed — core's
default retention exists for a reason). It has no access-control role. Configure the cleanup.

---

- Clear the temporary-files warning.
- Delete stale temp file entries on cron.
- Clean up temporary managed files.
- Avoid the status-report warning.
- Configure via system logging settings.
- Remove stale temp records.
- Understand it deletes temp entries.
- Ensure the cleanup fits your workflow.
- Not remove mid-workflow files prematurely.
- Have no access-control role.
- Run cleanup on cron.
- Manage temporary files.
- Suppress the temp warning.
- Configure the cleanup.
- Clean temp file entries.
- Address the status warning.
- Remove old temp files.
- Handle temporary-file buildup.
- Tidy the status report.
- Clean up on cron.
