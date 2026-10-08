<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Access Records

1. Install the contrib **Entity API** module (`drupal/entity`) — required for the query-access enforcement.
2. Enable `access_records`. Ensure **Field UI** is on to manage record fields.
3. Create an access record type at `/admin/structure/access-record`. Choose the target entity type it governs. Two fields are auto-created: a subject ID field (usually the user ID) and a target ID field (the target entity ID); both are optional and removable.
4. Add matching fields via Field UI. Field machine names drive matching:
   - Unprefixed name (e.g. `uid`, `field_uid`) matches on both subject and target.
   - `subject_`/`field_subject_` restricts matching to the subject side.
   - `target_`/`field_target_` restricts matching to the target side.
   - `ar_`/`field_ar_` marks a field as descriptive only (never matched).
5. Review `/admin/people/permissions` — grant the per-type or generic `view/create/update/delete [own] access_record` and `access access_record overview` permissions as needed. All are `restrict access: true`.
6. Create records linking subjects to targets. A record is itself the "reason" a subject may act on a target.

## Route-level gating
Add `_access_record: '<type_id>'` to a route's requirements to require the current user to hold a matching record. Multiple types: comma = AND, `+` = OR. Add `_access_operation: 'update'` (default `view`) to check a non-view operation. Admin-role users are always allowed by this check.
