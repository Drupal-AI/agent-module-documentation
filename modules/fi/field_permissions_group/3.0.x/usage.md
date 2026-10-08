<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Permissions Group lets you set field-level permissions to create, update or view fields within a Group context, integrating Field Permissions with Group.

---

Field Permissions Group extends the Field Permissions module with a Group-aware permission type: it
lets you control create/edit/view access to individual fields based on the user's membership and roles
within a Group. So a field can be visible/editable only to members holding a given group permission —
finer-grained, group-scoped field access than site-wide roles allow. It depends on the Field Permissions
and Group modules.

Use it on Group-based sites (communities, organizations, memberships) where certain fields should be
restricted per group. It is a genuine access-control feature: its `CustomGroupAccess` plugin grants
field access only when the account holds the specific group permission for the operation (fail-closed —
no membership/permission means no access), which is the correct restrictive default. When adopting,
verify the group-permission mapping matches your intent so field access aligns with group roles, and
remember field access is enforced wherever entity/field access is checked.

---

- Set field permissions by group.
- Restrict a field to group members.
- Control create/edit/view per group.
- Integrate Field Permissions with Group.
- Depend on field_permissions and group.
- Grant field access via group permission.
- Fail closed without the group permission.
- Scope field access to groups.
- Restrict fields per group role.
- Use on community/org sites.
- Verify group-permission mapping.
- Align field access with group roles.
- Enforce field access at the data layer.
- Hide fields from non-members.
- Allow field edit for members.
- Use the CustomGroupAccess plugin.
- Provide group-scoped field access.
- Restrict sensitive fields per group.
- Control field visibility by membership.
- Apply least-privilege field access.
