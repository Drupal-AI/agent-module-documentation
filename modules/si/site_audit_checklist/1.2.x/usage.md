<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site Audit Checklist

A dashboard for tracking pre-launch site-audit tasks: tasks are defined in a YAML checklist, shown on an admin page, updated per-task, and exportable to CSV.

- Ships a default checklist in `site_audit_checklist.checklist.yml`.
- Renders a dashboard of tasks and their status.
- Lets admins update individual task state.
- Exports the checklist to CSV.

---

# Installing & configuring

- Enable the module (`drush en site_audit_checklist`).
- View the dashboard at `/admin/config/development/site-audit`.
- The dashboard requires the `view site audit checklist` permission.
- Updating tasks and exporting require `administer site audit checklist`.
- Task definitions come from the module's checklist YAML.

---

# Usage & behaviour

- `SiteAuditChecklistController::dashboard` renders the checklist (view permission).
- `/admin/config/development/site-audit/update/{task_id}` (`TaskForm`) requires admin permission.
- `/admin/config/development/site-audit/export/csv` requires admin permission.
- Two permissions separate read (view) from write/export (administer).
- Tasks track completion state for launch readiness.
- The checklist is customizable via YAML.
- CSS/templates provide the dashboard styling.
- All routes live under `/admin/config/development/site-audit` (admin area).
- No anonymous-facing endpoints are exposed.
- The export is gated behind the administer permission, not view.
- Useful as a launch/QA gate for site builders.
- Menu and action links are provided for the dashboard.
- No external services are contacted.
- Uninstalling removes the dashboard and stored task state.
- The module is content-agnostic (audits the site, not specific nodes).
- Access is cleanly split between viewers and administrators.
