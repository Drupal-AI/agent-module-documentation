<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Usage Integrity watches the reference relationships tracked by the Entity Usage module and stops content editors from creating "dangling" references. When a published item references an unpublished item, or when someone tries to unpublish or delete an item that published content still points to, the module either warns the editor or blocks the operation, depending on a single site-wide mode setting.

---

The module builds on `entity_usage` (a hard dependency): Entity Usage records which entities reference which, and Entity Usage Integrity reads that data to judge whether each relationship is currently "valid". A relationship is valid when both the source and the target are published; it is invalid when a published source points at an unpublished target; it is ignored when the source itself is unpublished (or, optionally, when the referenced target is unpublished and the "ignore unpublished entities" option is on). It has no report screen and no runtime API of its own — it works entirely through `hook_form_alter` and a form-level validate handler that it attaches to every form. The behavior is governed by one setting page (route `entity_usage_integrity.settings`, path `/admin/config/entity-usage/integrity`, appearing as an "Integrity" tab under the Entity Usage settings, guarded by the `administer entity usage` permission). Two modes exist: warning (default) shows messages but always lets the editor save/delete; block prevents the offending save or disables the delete button. A second option, "ignore unpublished entities" (default on), skips relationships whose referenced entity is unpublished. When an edit form is opened, the module warns about the current item's invalid inbound and outbound references. When an edit form is submitted in block mode, it sets form errors to prevent saving an item that references unpublished content or would leave published content pointing at a now-unpublished item. On a delete form it lists the published items still referencing the entity, and in block mode disables the delete button. If Content Moderation is installed, it also validates moderation-state changes (including an AJAX confirmation dialog when a draft/unpublish transition is chosen). Paragraph child entities are resolved up to their non-paragraph parent, and translations are matched to the current language. Other modules can suppress the check on specific forms by subscribing to the `entity_usage_integrity.applicability_check` event.

- Warn editors (default) when they save a published node that references an unpublished node, media, or paragraph.
- Block saving entirely (block mode) when a published item would reference unpublished content.
- Prevent deleting an entity that published content still references, by disabling the delete button (block mode).
- Warn on the delete confirmation form that the entity is still referenced, listing the referencing items (warning mode).
- Stop an editor from unpublishing an item that published content still points to (block mode).
- Warn an editor who opens the edit form of an item that has broken/invalid references so they can fix them.
- Surface, on opening an edit form, that the current item is unpublished but is still referenced by published items.
- Enforce reference integrity for Content Moderation workflows when a draft or unpublish transition is selected.
- Show an AJAX confirmation dialog on moderation-state change (warning mode) if the new state would create invalid references.
- Keep an editorial site free of front-end links that resolve to inaccessible (unpublished or missing) content.
- Detect and log "broken" relations where Entity Usage still records a reference to an entity that no longer exists.
- Skip validation of unpublished referenced entities via the "ignore unpublished entities" toggle for looser workflows.
- Validate references only on the default (live) revision, so pending/forward revisions do not trigger false positives.
- Correctly attribute references through paragraphs by resolving them to their non-paragraph host entity.
- Match multilingual references to the current form language before judging validity.
- Let a developer disable integrity checks on chosen edit/delete forms via the applicability-check event.
- Give content teams a guardrail so publishing state and reference structure stay consistent site-wide.
- Provide a single site-wide policy (warn vs. block) for reference integrity rather than per-content-type rules.
- Log broken relations to a dedicated logger channel for later cleanup or restoration of missing targets.
- Complement Entity Usage's tracking with active enforcement at the moment of editing, unpublishing, or deleting.
- Help migration/cleanup projects catch references left dangling after bulk unpublishing or deletion.
- Act as a lightweight alternative to cascading-delete or reference-constraint modules for editorial safety.
