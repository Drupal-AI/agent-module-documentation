<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Access by Reference Field controls access to an entity based on the user's access to entities it references through an entity-reference field.

---

A common access rule is relational: a user may see a document if they can see the project it belongs to, or a page if they belong to the referenced group. Entity Access by Reference Field expresses that in configuration: enable the check on an entity-reference field, define a permission matrix mapping the host operation (view/update/delete) to the access checked on the referenced entity, and choose ANY (or) / ALL (and) behaviour when several entities are referenced. The access decision then delegates to the referenced entity's own access — which is the correct, idiomatic approach.

The implementation is careful: it returns neutral when the field is not configured, respects a global bypass permission, delegates to `$referencedEntity->access()` for each mapped operation, and attaches proper cache metadata. But there is one behaviour that is essential to understand, because getting it wrong means the module protects nothing.

**By default it fails open.** When the reference check does not grant access, the module returns the configured *fallback*, and that fallback **defaults to Neutral**. A neutral result does not deny — it lets other modules and core decide, and core's `access content` (held by everyone) then grants view access. So enabling the check on a field, without more, does **not** restrict access: it can only *add* access, never remove it. To actually restrict a host entity to users with reference access, the field's fallback must be set to **Forbidden**. This is idiomatically-correct hook behaviour — a `hook_entity_access` that returned Forbidden by default would break sites — but the module's name invites the assumption that enabling it locks content down, and it does not until the fallback is Forbidden.

So this is a precise tool used precisely: define the permission matrix, choose AND/OR, and above all set the fallback to Forbidden when the intent is to restrict. One minor note: the "is referenced user" matrix option grants access both when the current user *is* the referenced user and when they hold delete access on it, which is slightly broader than the label suggests.

---

- Grant entity access by a reference.
- See a document if you can see its project.
- Restrict a page to a referenced group's members.
- Delegate access to a referenced entity.
- Map host operations to referenced access.
- Use ANY or ALL for multiple references.
- Set the fallback to Forbidden to restrict.
- Avoid failing open by default.
- Configure a per-field permission matrix.
- Grant a global bypass permission.
- Restrict content relationally.
- Base access on group membership.
- Understand Neutral does not deny.
- Lock down a host entity properly.
- Delegate to referenced entity access.
- Add reference-based access rules.
- Restrict by project reference.
- Set fallback per field.
- Control view/update/delete by reference.
- Confirm the fallback is Forbidden.
- Model relational permissions.
- Avoid a false sense of restriction.