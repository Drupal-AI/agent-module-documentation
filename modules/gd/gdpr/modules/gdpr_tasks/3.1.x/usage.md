<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GDPR Tasks manages the workflow for GDPR data requests: Subject Access Requests (SAR — export a user's data) and Right-to-be-Forgotten removal requests (anonymize/delete a user's data), building on the field metadata from GDPR Fields.

---

The module defines a **Task** content entity `gdpr_task` with a **config bundle** `gdpr_task_type` (config entity, `config_prefix gdpr_task_type`), shipping two default types: **`gdpr_sar`** ("SARs Request", data access/export) and **`gdpr_remove`** ("Removal request", right to be forgotten). Tasks are created for a user (via `/user/{user}/gdpr-request/{gdpr_task_type}`, route `gdpr_tasks.request`, permission `create gdpr tasks`), listed/administered at `/admin/config/gdpr/tasks`, and summarized at `/admin/config/gdpr/summary` (route `gdpr_tasks.summary`). Processing uses the GDPR Fields collector and **entity traversal** services (`gdpr_tasks.rta_traversal`, `gdpr_tasks.rtf_traversal` and display variants, built via `EntityTraversalFactory`) to walk a subject's data graph following the relationships configured in GDPR Fields; a SAR builds an export (a queue worker `gdpr_tasks_process_gdpr_sar` assembles it, requiring the `zip` PHP extension), and a removal anonymizes/removes fields per their RTF settings using the `gdpr_tasks.anonymizer` service. A Right-to-be-Forgotten settings form lives at `/admin/config/gdpr/remove-settings` (route `gdpr_tasks.remove_settings`, permission `administer task entities`). It fires Rules events (`gdpr_tasks.rules_rta_complete`, `gdpr_tasks.rules_rtf_complete`), adds a field type `gdpr_task_item` (task log), and defines permissions `create gdpr tasks`, `view gdpr tasks`, `add/administer/delete/edit/view task entities` and `view gdpr data summary`. Requires `gdpr`, `anonymizer`, `gdpr_fields`, `entity`, `file`, `views`, `options`.

---

- Let a user request an export of all data held about them (Subject Access Request).
- Process a Right-to-be-Forgotten request that anonymizes a user's personal fields.
- Track the status of each data request from creation to completion.
- Create a SAR task for a user from `/user/{uid}/gdpr-request/gdpr_sar`.
- Create a removal task from `/user/{uid}/gdpr-request/gdpr_remove`.
- Review all outstanding GDPR tasks at /admin/config/gdpr/tasks.
- See a compliance summary at /admin/config/gdpr/summary.
- Define a custom task type (bundle) beyond the shipped SAR/removal types.
- Build a subject's full data export by traversing related entities.
- Anonymize fields per their GDPR Fields RTF settings on removal.
- Package a SAR export as a zip via the queue worker.
- Configure right-to-be-forgotten behavior at /admin/config/gdpr/remove-settings.
- Trigger a Rules reaction when a data access request completes.
- Trigger a Rules reaction (e.g. send email) when a removal completes.
- Let staff create GDPR requests on behalf of users.
- Restrict who can create/administer tasks via dedicated permissions.
- Record a task processing log with the gdpr_task_item field.
- Give users a "my data requests" view linked from the GDPR user page.
- Follow entity-reference relationships when collecting a subject's data.
- Keep an auditable workflow of GDPR requests for compliance.
- Combine with GDPR Fields to control exactly which fields are exported/removed.
- Handle SAR and removal as distinct task types with their own displays.
