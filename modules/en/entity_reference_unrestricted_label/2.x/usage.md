<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Unrestricted Label provides one entity-reference field formatter, "Label (access bypass)", that renders the label of every referenced entity to all users regardless of entity access — a deliberate, advertised bypass for showing that referenced content exists.

---

Core's standard entity-reference label formatter filters out referenced entities the current user cannot view, so a viewer never sees the labels of content they lack access to. This module ships a formatter that intentionally does the opposite: its annotation states plainly that it displays labels "without performing any access check", and it is titled "Label (access bypass)". Under the hood, its `EntityReferenceUnrestrictedLabelFormatter::getEntitiesToView()` returns every loaded referenced entity, omitting the access gate core applies, and renders only each entity's label as escaped plain text (no link, no other fields). This is useful when you want to reveal that referenced entities exist — by their titles — while keeping the entities themselves access-restricted: an e-learning course listing the exams available for it even though the exams are only viewable by registered users, or a magazine showing subscriber-only article titles to anonymous visitors. The formatter has no settings; you simply select it as a field's Format on Manage display. Because the bypass is intentional, choose it only where the referenced labels are safe to show to everyone who can see the field, and use core's access-respecting Label formatter anywhere those titles should stay hidden.

---

- Show the labels of referenced entities to every user, regardless of access.
- Reveal that access-restricted content exists without exposing the content itself.
- List exam titles on a course page while the exams stay registered-users-only.
- Show subscriber-only article titles to anonymous visitors.
- Display the names of referenced entities the current user cannot view.
- Present a taxonomy of public labels drawn from otherwise-restricted entities.
- Render referenced-entity titles as escaped plain text (no link, no body).
- Select "Label (access bypass)" as an entity-reference field's Format on Manage display.
- Apply it to node, user, term, media, or any entity_reference field.
- Use it as a drop-in alternative to core's Label formatter when you need the bypass.
- Advertise related-but-gated items by name on a public page.
- Show which documents are attached to a record even to users who cannot open them.
- Display referenced group or organization names to non-members.
- List the titles of referenced unpublished drafts on an editorial dashboard for all editors.
- Surface reference labels in a view mode consumed by anonymous traffic.
- Keep entity access intact while still labeling relationships in the UI.
- Provide breadcrumb-style context using labels of parent entities the user cannot open.
- Confirm referenced labels are non-sensitive before choosing this formatter.
- Prefer core's Label formatter where referenced titles must respect access.
- Enable the module, then switch specific fields to it one at a time.
- Combine with a restricted view-display so only chosen fields expose labels.
- Audit which fields use "Label (access bypass)" when reviewing what a role can see.
