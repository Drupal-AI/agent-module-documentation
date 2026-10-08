<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access Records — extension API

The module exposes hooks in `access_records.api.php` to extend or alter the access mechanic:

- The set of supported operations (default `view`, `update`, `delete`) can be extended/modified via hooks, letting you define custom operations that access records answer.
- Query access is driven by `AccessRecordQueryBuilder` (`access_records.query_builder`) and the `entity.query_access` event; `AccessRecordsQueryAccessSubscriber::onQueryAccess()` builds a UNION of per-type subqueries and adds an `id IN (…)` condition, or `alwaysFalse()` when there are no matches or a type config is invalid.
- Views integration: access plugin `AccessRecords`, field handlers (`AccessRecordSubjectId`, `AccessRecordTargetId`) and relationships (`AccessRecordData`, `AccessRecordSubject`, `AccessRecordTarget`).
- Bulk actions: `AccessRecordsGrant` / `AccessRecordsRevoke` (derived per type) create or delete records for selected entities.
- Tokens are provided via `access_records.tokens.inc`.

When a type's configuration is incomplete/invalid the subscriber blocks access on the affected target entity type and logs an `alert`, keeping the failure fail-closed until fixed.
