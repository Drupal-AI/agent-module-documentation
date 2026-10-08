<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Trash Manager provides a trash manager for restoring deleted entities.

---

Trash Manager **provides a recycle bin for deleted entities** — on entity delete it records the entity (via
`hook_entity_predelete`) into a trash table so it can be **restored** later, and provides a form to
**permanently delete** trashed items. It depends on core System and provides its own permissions, in the
Administration package.

Use it to recover accidentally-deleted content. It is a content-administration/data-protection feature with access
considerations you should verify: **restore** re-creates an entity (which could resurrect content someone deleted
intentionally) and **permanent delete** is irreversible, so both operations should be **gated by appropriate
permissions and access checks** — grant the trash-management permissions only to trusted administrators, and ensure
a user can only restore/purge items they'd have had delete/create access to. Also note the trash may **retain
copies of deleted content** (which can include sensitive data) — factor that into data-retention/GDPR handling
(purge when required). Configure the trash-management permissions.

---

- Record entities on delete (recycle bin).
- Allow restoring deleted entities.
- Provide a permanent-delete form.
- Depend on core System + provide permissions.
- Serve content administration/data protection.
- Recover deleted content.
- GATE restore + permanent-delete to trusted users (verify access).
- Note restore re-creates an entity + permanent delete is irreversible.
- Ensure users only restore/purge items they'd have delete/create access to.
- RETAIN copies of deleted content (sensitive data - factor into retention/GDPR; purge when required).
- Configure the trash-management permissions.
- Handle the recycle bin.
- Restore entities.
- Configure the trash.
- Recover content.
- Handle deletions.
- Purge items.
- Manage trash.
- Restrict the permissions.
- Provide a trash/recycle bin.
