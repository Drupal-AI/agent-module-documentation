<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VBO Workflow Transition adds a Views Bulk Operations action that moves selected entities through a workflow transition.

---

Moderating content one item at a time is fine until there are two hundred items. A migration lands everything as draft, an editorial review approves a batch, a campaign ends and its content should all be archived — each is one decision applied many times, and doing it individually is both slow and error-prone.

This action puts the transition into Views Bulk Operations, so the selection happens through a View with all its filters, and the transition applies to what was selected.

Two properties follow from doing it through moderation rather than by writing states directly, and both matter. **Transition access is still checked per entity** — content moderation decides whether the current user may make that transition on that item — so a bulk operation cannot do what the user could not do one at a time. And **the transition's side effects still run**, so notifications, hooks and revision creation behave as they would normally.

The thing to be careful about is the selection, not the action. VBO can apply to every row matching a View, including rows on pages the operator never looked at. Filter deliberately, check the count before confirming, and prefer a View that shows what will be affected over one that merely finds it.

---

- Publish two hundred drafts at once.
- Archive a campaign's content in bulk.
- Approve a batch after review.
- Transition content selected by a View filter.
- Apply a moderation transition to many items.
- Keep per-entity transition access checks.
- Preserve notifications and hooks on bulk changes.
- Create revisions for each transitioned item.
- Clean up after a content migration.
- Select items with Views filters.
- Check the affected count before confirming.
- Avoid acting on rows nobody looked at.
- Use a View that shows what will change.
- Undo a bulk transition deliberately.
- Report on bulk moderation activity.