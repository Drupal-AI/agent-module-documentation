<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Read-Only by Role marks fields editable for some roles and read-only for others without hiding them.

---

Field Read-Only by Role **makes fields read-only for chosen roles** — configuring, per role, which fields are
editable and which are shown read-only (not hidden) on entity forms. It provides its own permissions.

Use it to soft-lock fields for certain roles. Understand its enforcement precisely (recorded as a campaign security
finding): the restriction is applied **only in `hook_form_alter()`**, which sets the widget's `#disabled = TRUE`
(and hides format/editor-switch controls). Core's Form API does respect `#disabled` (disabled elements ignore
submitted input), so a read-only-role user genuinely **cannot change the field through the entity form**. But the
module implements **no `hook_entity_field_access()`**, so the read-only rule provides **zero protection on any
non-form write path** — a user in a "read-only" role who has entity edit access can still change the field via
**JSON:API `PATCH`** (core, commonly enabled), **REST**, **Quick Edit**, **Views Bulk Operations**, or programmatic
writes. So this is a **UI convenience, not a field-access control**: do not rely on it to stop a role from editing a
sensitive field. To actually protect a field per role, use `hook_entity_field_access()` (or a field-permissions
module) so the restriction is honoured everywhere. Configure the read-only rules with this understanding.

---

- Mark fields read-only per role.
- Keep the fields visible (not hidden).
- Soft-lock fields for chosen roles.
- Provide its own permissions.
- Serve content editing.
- Restrict field editing by role.
- ENFORCE only via hook_form_alter (#disabled) — NO hook_entity_field_access.
- PROTECT on the entity form (core respects #disabled) but NOT on non-form paths.
- BE BYPASSED by JSON:API/REST/Quick Edit/VBO/programmatic writes.
- BE a UI convenience, NOT a field-access control (don't rely on it to protect a field).
- Use hook_entity_field_access() / field permissions for real per-role field protection.
- Configure the read-only rules with this understanding.
- Handle read-only fields.
- Disable fields.
- Configure the rules.
- Lock fields.
- Handle the form.
- Gray out fields.
- Not trust it as access.
- Provide role-based field read-only (UI).
