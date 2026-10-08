<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Two permissions (`alt_text_validation.permissions.yml`), neither flagged
`restrict access: true`:

| Permission | Gates |
|---|---|
| `administer alt text validation` | The settings form (`alt_text_validation.setting`) and full CRUD on `alt_text_rule` config entities (`entity.alt_text_rule.*` routes; also the entity's `admin_permission`). |
| `view alt text validation reports` | The Alt Text Report view (`/admin/reports/alt-text-report`) and the batch rebuild route (`/admin/reports/alt-text-report/rebuild`). |

Notes:
- On-save alt-text validation itself is **not** permission-gated — it applies via the field
  constraint to anyone editing a covered field; it is controlled by the
  `alt_text_validation_enabled` master switch and each rule's `violation_action`.
- The report exposes alt text and titles drawn from content across all entity types, so
  `view alt text validation reports` is effectively a site-wide content-audit view; grant it
  to editorial/QA roles accordingly.
- The batch rebuild triggers a full-site audit and is available to report viewers (not just
  administrators).
