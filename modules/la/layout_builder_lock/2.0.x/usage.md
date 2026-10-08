<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder Lock lets site builders lock individual Layout Builder sections so content editors working on an override cannot add, move or remove blocks, or insert new sections before/after — preserving a designed layout while still letting editors change what they are allowed to.

---

When Layout Builder is opened up to editors on per-entity overrides, a carefully designed default layout can be pulled apart — blocks deleted, sections added, order changed. Layout Builder Lock adds per-section lock settings (configured on the default layout by users with the right permission) that constrain what editors may do to that section on an override: block add, block move/update, block delete, and adding sections before or after can each be locked.

Enforcement is driven by a set of granular permissions — `manage lock settings on default display`, `manage lock settings on overrides`, `bypass lock settings on layout overrides`, and `remove sections with lock settings`. Editors without the bypass permission see the locked affordances removed in the Layout Builder UI for that section. Because the value of a lock ultimately depends on Layout Builder's own access model, treat it as governance/guard-railing for editors who already have layout access rather than a hard security boundary against a determined actor with override access.

For editorial teams using Layout Builder overrides, it keeps brand/structure intact while still granting per-entity flexibility. The setup task is deciding, per section on the default layout, which operations to lock and which roles get the bypass permission.

---

- Lock a Layout Builder section from editing.
- Prevent editors from deleting a block in a section.
- Prevent adding new blocks to a locked section.
- Stop editors adding sections before/after a locked one.
- Preserve a designed default layout on overrides.
- Allow layout overrides but protect key sections.
- Grant a role permission to manage lock settings.
- Let a trusted role bypass locks on overrides.
- Control who can remove locked sections.
- Keep a hero section fixed across nodes.
- Guard-rail editors using Layout Builder.
- Lock block moves within a section.
- Configure lock settings on the default display.
- Protect a footer section from override edits.
- Standardize layout governance for a content type.
- Limit override editing to specific sections.
- Prevent structural changes to a template layout.
- Apply per-section editing constraints.
- Keep marketing layouts on-brand.
- Separate "manage locks" from "bypass locks" duties.