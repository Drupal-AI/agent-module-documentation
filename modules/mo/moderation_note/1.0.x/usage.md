Moderation Note lets reviewers select text in a field of a moderated entity and attach a threaded, assignable, resolvable note to it — an in-context editorial commenting layer for content moderation, all in the front-end.

---

The module defines a `moderation_note` content entity that records the note text plus the exact place it annotates: the target entity type/id, field name, langcode, view mode, the selected `quote`, and a character `quote_offset`. Notes are created by selecting text on the latest revision of a moderated entity and clicking "Add note"; they render in an off-canvas sidebar via AJAX (custom Ajax commands add/reply/remove). Notes support threaded **replies** (a `parent` reference), **assignment** to a user (adds the note to that user's "Assigned notes" toolbar tab / `/user/{user}/moderation-notes`), and **resolve / re-open / delete**. Access is deliberately tied to the annotated content: viewing a note requires the `access moderation notes` permission *and* view access to the moderated entity; creating requires `create moderation notes` (or `create moderation notes on uneditable entities` when the user cannot edit the entity); editing/deleting/resolving is limited to the note owner (or `resolve moderation notes on editable entities` for users who can edit the content), with an `administer moderation notes` override. Email notifications (toggleable at `/admin/config/moderation-note`, on by default) go to the entity author/last-updater, assignee, and thread participants on create/assign/resolve/reopen/reply, using a themable mail template and a dedicated `NoteMail` mail plugin. Each note is tied to a field langcode so translations can be reviewed independently. Ships Views integration (a note-link field), a per-user menu count, an entity-reference selection handler for assignees, templates, and a JS library. Requires core `content_moderation` and `user`.

---

- Leave in-context review feedback by selecting text in a field and attaching a note.
- Run editorial review on a Draft (latest, unpublished) revision without emailing back and forth.
- Thread a discussion on a note via replies before resolving it.
- Assign a note to a specific editor so it shows in their "Assigned notes" toolbar tab.
- Track a reviewer's outstanding notes at `/user/{uid}/moderation-notes`.
- Resolve a note once addressed, then re-open or permanently delete it later.
- Notify content authors and assignees by email when notes are created, assigned, resolved, or replied to.
- Disable all email notifications from a single settings toggle.
- Customize the notification email by overriding `templates/mail-moderation-note.html.twig`.
- Let reviewers who cannot edit content still add notes (`create moderation notes on uneditable entities`).
- Restrict note visibility to users who can already view the moderated content.
- Review the same content concurrently in different languages (notes are per-langcode).
- Give editors who can update content the ability to resolve others' notes on that content.
- Add a moderation-note link/column to a View via the provided Views field.
- Show a live count of assigned notes in the toolbar for each user.
- Pick assignees through the module's entity-reference selection handler.
- Annotate any moderated entity type, not just nodes.
- Keep review notes out of the rendered content (stored separately, shown in an off-canvas sidebar).
- Delegate full note administration to a trusted role via `administer moderation notes`.
- Preview content and jump back to its notes list via the built-in "Back" link.
- Provide a resolvable feedback loop for a multi-step publishing workflow.
- Audit editorial discussion history through resolved (re-openable) notes.
