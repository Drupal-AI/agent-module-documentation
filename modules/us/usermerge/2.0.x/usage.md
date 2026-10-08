<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Merge provides an advanced mechanism to merge user accounts together.

---

User Merge provides an advanced mechanism to merge two user accounts — consolidating their content,
references and (per configuration) roles from one account into another, then removing/blocking the merged
account. This is useful when a person has ended up with duplicate accounts. It provides its own permissions
(gated by a dedicated `merge accounts` permission), in the User management package.

Use it to consolidate duplicate accounts. **This is a powerful, sensitive administrative operation** — merging
reassigns content/authorship and can transfer roles between accounts, so: gate the `merge accounts` permission
to **fully-trusted administrators** only, review exactly what is transferred (especially roles/permissions —
merging could grant one account's roles to another), and treat it as irreversible (back up first). It is an
access-control-adjacent operation but its safety rests on the permission gating. Configure the merge
behaviour and run it carefully.

---

- Merge two user accounts.
- Consolidate content/references/roles.
- Handle duplicate accounts.
- Provide the merge accounts permission.
- Remove/block the merged account.
- Reassign content/authorship.
- TREAT it as a powerful/sensitive operation.
- Gate merge accounts to fully-trusted admins.
- Review what is transferred (esp. roles).
- Treat it as irreversible (back up first).
- Have no access-control role beyond the permission.
- Configure the merge behaviour.
- Handle account merging.
- Merge accounts.
- Consolidate accounts.
- Restrict merging.
- Handle the merge.
- Merge users.
- Configure merging.
- Consolidate duplicates.
