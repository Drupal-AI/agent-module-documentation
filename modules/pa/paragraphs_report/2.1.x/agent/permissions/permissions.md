<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions (`paragraphs_report.permissions.yml`)

All three are `restrict access: TRUE`.

| Machine name | Gates |
|---|---|
| `administer paragraphs_report configuration` | The settings form `paragraphs_report.settings` (`/admin/reports/paragraphs-report/settings`) — choosing content types, hidden paragraphs, batch size, and the watch toggle. |
| `access paragraphs report` | Viewing the report `paragraphs_report.report` and the CSV export `paragraphs_report.export`. |
| `update report data` | Triggering a report rebuild via `paragraphs_report.data` (`/admin/reports/paragraphs-report/update`) — the "Update Report Data" button is only shown to users with this permission. |

The `drush paragraphs_report:update` command runs as the CLI user and is not gated by these permissions.
