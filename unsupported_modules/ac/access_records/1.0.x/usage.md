<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Manageable content entities ("access records") that model who may do what regarding which content, and enforce that at entity and route level.
---
An access record type defines a target content entity type; each record links one or more subjects (usually users) to one or more targets by matching field values ("having at least one of the values"). Matching is by field machine name, with `subject_`/`target_` prefixes to scope a field to one side and an `ar_` prefix to exclude a field from matching. The module ships an access control handler (`AccessRecordAccessControlHandler`) for the records themselves and a query-access handler plus an event subscriber (`AccessRecordsQueryAccessSubscriber`) that injects matching conditions into target-entity queries via the contrib Entity API query-access layer.

Every operation is permission-gated: per-type and generic `view/create/update/delete [own] access_record` permissions plus `administer access_record`, and all permissions are declared `restrict access: true`. Routes (revisions, admin overviews) require `access access_record overview` or revision access checks; there are no anonymous or mutating public endpoints. A custom route access check (`_access_record`) lets other routes require the current user to hold at least one matching record of given types (comma = AND, `+` = OR), and the query-access handler falsifies queries when a user has no matching records so nothing leaks. Setup: install contrib Entity API, create access record types at `/admin/structure/access-record`, add fields via Field UI, then create records.
---
- Model "who can do what to what" as editable content entities.
- Create access record types bound to a specific target entity type.
- Grant a user access to specific content by creating a record linking them.
- Match subjects and targets by shared field values (roles, IDs, strings).
- Scope a field to subjects only with a `subject_`/`field_subject_` prefix.
- Scope a field to targets only with a `target_`/`field_target_` prefix.
- Exclude descriptive fields from matching using the `ar_` prefix.
- Add custom fields to access record types via Field UI.
- Enforce view/update/delete access on target entities via query access.
- Require Entity API (contrib) to enable database-level query access.
- Gate routes on holding a matching record using the `_access_record` requirement.
- Combine required record types with AND (comma) or OR (`+`).
- Assign per-type permissions like `view own <type> access_record`.
- Grant overview access with `access access_record overview`.
- Administer all records with the `administer access_record` permission.
- Track record changes through revisions and revert or delete them.
- Translate access records where languages are enabled.
- Use bundled Views integration (relationships, fields, access plugin).
- Apply Grant/Revoke actions in bulk from Views/admin listings.
- Extend allowed operations via hooks (see access_records.api.php).
- Build subject/target overview pages under `/admin/content/access-record/*`.
- Falsify queries automatically so users without records see no target rows.
- Audit why a user has access by inspecting the matching record.