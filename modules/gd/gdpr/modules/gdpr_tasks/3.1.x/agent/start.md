<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GDPR Tasks — agent index

Workflow for GDPR data requests: **Subject Access Requests** (SAR, export a user's data) and
**Right-to-be-Forgotten** removal (anonymize/delete). Builds on GDPR Fields. Requires `gdpr`,
`anonymizer`, `gdpr_fields`, `entity`, `file`, `views`, `options`. No single settings form
(`configure: null`).

- **The `gdpr_task` entity, the `gdpr_task_type` bundles (SAR/removal), routes and the
  removal-settings form** → [configure/tasks.md](configure/tasks.md)
- **Processing internals: traversal services, anonymizer, queue worker, Rules events** →
  [api/processing.md](api/processing.md)

Key facts:
- Content entity `gdpr_task` with config bundle entity `gdpr_task_type`
  (`config_prefix gdpr_task_type`); default types `gdpr_sar` ("SARs Request") and
  `gdpr_remove` ("Removal request").
- Routes: create `/user/{user}/gdpr-request/{gdpr_task_type}` (`gdpr_tasks.request`), list
  `/admin/config/gdpr/tasks`, summary `/admin/config/gdpr/summary`, removal settings
  `/admin/config/gdpr/remove-settings`.
- Services: `gdpr_tasks.manager`, `gdpr_tasks.anonymizer`, `gdpr_tasks.rta_traversal` /
  `gdpr_tasks.rtf_traversal` (+ display variants). Queue worker `gdpr_tasks_process_gdpr_sar`.
- Field type `gdpr_task_item`; Rules events `gdpr_tasks.rules_rta_complete` /
  `gdpr_tasks.rules_rtf_complete`.
- Permissions: `create gdpr tasks`, `view gdpr tasks`, `add/administer/delete/edit/view task
  entities`, `view gdpr data summary`.
