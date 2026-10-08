<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit Files — agent index

Seven admin **reports** that reconcile files on disk vs `file_managed` vs `file_usage` vs content
references, with batch fix actions. Config lives in the `auditfiles.settings` config object;
configure route `auditfiles.configuration`. Two permissions. **No Drush commands.** Fix logic is
dispatched as events (handled by `AuditFilesListener`) and exposed as per-report auditor services.

- **Settings keys, the config route, and the seven report routes/paths (what each finds)** →
  [configure/settings-and-reports.md](configure/settings-and-reports.md)
- **Auditor services + the events you can subscribe to, to extend fix behavior** →
  [extend/events-and-services.md](extend/events-and-services.md)
- **The two permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Settings object: `auditfiles.settings` (scheme, exclusions, items-per-page, max records, date format).
- Reports base: `/admin/reports/auditfiles/<report>`; settings: `/admin/config/system/auditfiles`.
- The module edits the file tables **directly** (not via the File API) so repairs don't create new problems.
