A Views Bulk Operations action that moves content-moderation entities through their workflow in bulk, letting a user pick any transition they are allowed to make and apply it to the selected rows.

---

VBO Workflow Transition ships a single VBO action, "Transition content to a new workflow state", for sites that use Content Moderation. You add the "Global: Views bulk operations" field to a View that lists moderated entities (nodes, media, or any editorial entity type), then editors select rows and run the action. The action expands the selection (including "select all pages"), figures out which transitions the current user can actually perform on each selected entity, and presents a confirmation page grouped by workflow and transition — each transition shows how many of the selected entities are eligible and lists them with their current (and, if different, latest) moderation state. The user optionally enters a revision log message, then clicks the button for the single transition to run. On submit every eligible entity is saved as a new revision with the target moderation state; entities that don't match the chosen workflow/transition are quietly skipped. There is no admin settings page and the module defines no permissions of its own — visibility and what transitions appear are governed entirely by core VBO/Views access and Content Moderation's per-transition permissions.

---

- Bulk-publish a backlog of Draft nodes by selecting them in a moderated-content View and running the "Publish" transition in one batch.
- Move many articles from Draft to "Needs Review" at once so a reviewer can pick them up.
- Bulk-archive or unpublish outdated content by transitioning it to an Archived/Unpublished state.
- Send a set of pages back to Draft (reject) after an editorial review, with a revision log message explaining why.
- Approve a queue of user-submitted content that is sitting in a "Pending" moderation state.
- Apply a custom workflow transition (e.g. "Send to Legal") defined in your own workflow to a group of entities.
- Transition moderated Media items (not just nodes) in bulk, since the action works on any EditorialContentEntityBase type.
- Process a large "select all pages" selection where only some rows are eligible for a given transition — eligible rows are transitioned, the rest are skipped.
- Give each bulk transition a shared revision log message that then appears on every affected entity's Revisions tab.
- Roll a set of translated entities forward, transitioning the correct latest-affected revision per language.
- Let a Content Editor role run only the transitions their moderation permissions allow, while an Administrator sees more transitions for the same selection.
- Clear a moderation queue after an event by transitioning all "Submitted" items to "Published" together.
- Batch-move seasonal or campaign content into an "Unpublished" state once a promotion ends.
- Preview, before committing, exactly how many of the selected entities can make each available transition and which ones they are.
- Replace ad-hoc one-by-one moderation clicks with a single confirmed bulk operation from a curated View.
- Combine with Views filters (by content type, author, date, current moderation state) to target precisely which moderated entities get transitioned.
- Use it as a lighter-weight alternative to Moderated Content Bulk Publish when you need arbitrary workflow transitions rather than only Draft/Publish/Unpublish.
- Run scheduled editorial sweeps: filter a View to stale "In Review" content and bulk-transition it back to Draft.
- Ensure each bulk state change produces a proper new revision attributed to the acting user (revision user, revision time, and changed time are all set).
