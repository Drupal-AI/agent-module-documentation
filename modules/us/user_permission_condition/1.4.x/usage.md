<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Permission Condition adds a condition plugin that tests whether the current user holds a given **permission**, rather than a given role.

---

Core's condition set offers a role check, and role is a proxy for what you actually mean. A block that should appear for people who can edit content is really about the `edit any article content` permission; expressing it as "editor OR content manager OR administrator" means revisiting every such condition whenever a role is added, and getting it wrong somewhere. A permission condition states the intent directly and keeps working when the role structure changes — which is the same reason permissions rather than roles are the right basis for access checks in code. Because it is an ordinary condition plugin it works anywhere conditions are consumed: block visibility, Context, Page Manager and custom code through the condition manager. It depends on core `user` alone, with core `^9.5 || ^10 || ^11`. The standard caveats for any visibility condition apply and are worth repeating: it decides what is **shown**, not what a user may **access**, so it is never a substitute for a real access check; and a response that varies on it needs the matching `user.permissions` cache context, or the page cache will serve one visitor's variant to another.

---

- Show a block to users with a specific permission.
- Express intent rather than listing roles.
- Avoid updating conditions when roles change.
- Show an editor toolbar block by permission.
- Target a help block at content editors.
- Combine permission and path conditions.
- Show a moderation block to reviewers.
- Reduce brittle role lists.
- Drive a Context reaction from a permission.
- Show admin guidance to those who can act.
- Keep visibility aligned with capability.
- Target a block at users who can publish.
- Support a fine-grained permission model.
- Show a shortcut to those who can use it.
- Reuse the condition across block and Context.
- Reduce duplicated visibility rules.
- Show a link only to the permitted.
- Simplify a complex role structure.
