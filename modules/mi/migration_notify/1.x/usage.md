<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migration Notify sends different notifications based on the status of migrations (success, failure, etc.).

---

Migration Notify sends notifications based on migration status/outcome — so when a migration runs
(completes, fails, has errors), configured notifications (typically email) are sent, alerting the team to
migration results without manually checking. It depends on the Migrate module (>=8.3) and is configured at
`migration_notify.settings`.

Use it to get alerted on migration outcomes (useful for scheduled/automated migrations). It is a
developer/migration operational tool; notifications may include migration status detail, so ensure the
recipients are appropriate. It has no content-access role. Configure the notifications and triggers.

---

- Notify on migration status.
- Alert on migration success/failure.
- Send migration-outcome notifications.
- Depend on the Migrate module.
- Configure at migration_notify.settings.
- Alert on migration errors.
- Avoid manually checking migrations.
- Ensure appropriate recipients.
- Have no content-access role.
- Configure notifications and triggers.
- Get migration alerts.
- Notify the team on results.
- Support automated migrations.
- Send email on completion.
- Track migration outcomes.
- Alert on failures.
- Configure the triggers.
- Monitor migration runs.
- Send status notifications.
- Handle migration alerts.
