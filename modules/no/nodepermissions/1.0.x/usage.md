<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Granular Node Permissions provides separate per-field permissions to manage protected node administrative fields (uid, status, created, promote, sticky).

---

Granular Node Permissions (nodepermissions) adds fine-grained permissions for the node administrative
fields that core normally restricts to the broad `administer nodes` permission — author (`uid`), published
`status`, `created` date, `promote` and `sticky`. Via `hook_entity_field_access()` it grants edit access to
each of these fields to holders of a dedicated permission (e.g. `administer node status`) using
`AccessResult::allowedIfHasPermission()`. It depends on core Node.

Use it to delegate specific node-admin capabilities without granting full `administer nodes` — for example,
letting a role set the published status but not change authorship. It is an access-control/delegation
feature. **Assign these permissions to match your trust model:** each delegates a sensitive capability —
`administer node uid` lets a user change a node's author (authorship spoofing), `administer node status`
lets them publish/unpublish, `promote`/`sticky` affect front-page/ordering. So grant them deliberately.
Because it uses `allowedIfHasPermission` (an additive grant), it opens up these fields to permission-holders;
it does not restrict beyond core's defaults. Configure the permissions on the roles that should have them.

---

- Add per-field node admin permissions.
- Delegate editing of status/author/etc.
- Grant administer node status separately.
- Split up the administer nodes permission.
- Grant via hook_entity_field_access.
- Depend on core Node.
- Let a role set published status only.
- Assign permissions to match trust.
- Know administer node uid = authorship control.
- Know administer node status = publish control.
- Grant promote/sticky deliberately.
- Delegate without full administer nodes.
- Use allowedIfHasPermission (additive grant).
- Open fields to permission-holders.
- Configure per-role permissions.
- Grant granular node access.
- Delegate node-admin capabilities.
- Restrict deliberately.
- Control admin-field editing.
- Assign sensitive permissions carefully.
