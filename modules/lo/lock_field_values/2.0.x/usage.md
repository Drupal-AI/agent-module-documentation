<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lock Field Values allows administrators and editors to lock field values so they can not be changed by non-authorized users.

---

Lock Field Values lets administrators/editors **lock** specific field values on content — so once locked,
that value can't be changed by users who don't hold the unlock permission, protecting critical field values
(a price, a legal field, a slug) from accidental or unauthorized edits. It depends on core Field, provides
its own permissions, in the Fields package.

Use it to protect field values from unauthorized change. This is a content-integrity/field-level control: it
restricts **editing** of the locked field (enforced on the edit form/field access), so a non-authorized user
can't modify a locked value. When adopting: grant the lock/unlock permissions to the right roles, and note
this governs *who may change the field value*, not who may *view* it. It complements normal field/entity
access. Configure which fields can be locked.

---

- Lock field values from change.
- Protect critical field values.
- Prevent unauthorized edits of a value.
- Depend on core Field.
- Provide its own permissions.
- Guard a price/legal field/slug.
- Restrict editing of the locked field.
- Enforce on the edit form/field access.
- Grant lock/unlock permissions to the right roles.
- Govern who may CHANGE (not view) the value.
- Complement normal field/entity access.
- Have no other access-control role.
- Configure which fields can be locked.
- Handle field locking.
- Lock values.
- Configure the lock.
- Protect values.
- Handle the lock.
- Restrict field editing.
- Lock critical values.
