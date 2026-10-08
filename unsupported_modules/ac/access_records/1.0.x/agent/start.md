<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access Records (access_records) — agent index
**Content entities that encode access rules and enforce them on target entities via the Entity API query-access layer.**

- **Version:** 1.0.x
- **Core:** ^10.3 || ^11
- **Depends on:** user, options, entity (contrib Entity API — required for query access)
- **Type UI:** `/admin/structure/access-record`; records overview under `/admin/content/access-record/{subjects,targets,subjects-targets}` (needs `access access_record overview`).
- **Permissions:** per-type + generic `view/create/update/delete [own] access_record`, `administer access_record`, `administer access_record_type`, revision perms — all `restrict access: true`.
- **Access checks:** entity handler `AccessRecordAccessControlHandler`; route check `_access_record` (+ optional `_access_operation`); query-access via `AccessRecordsQueryAccessSubscriber` / `AccessRecordQueryAccessHandler`.

**Security:** Reviewed — access is deny-by-default. The query-access handler emits `alwaysFalse()` conditions when a user has no matching record, and the entity handler requires explicit permissions per operation; no anonymous or mutating public routes. See [configure/access-records.md](configure/access-records.md) and [api/hooks.md](api/hooks.md).
