Entity Notes lets you attach free-text notes to any content entity type and view/manage them from a "Entity Notes" tab on that entity.

---

Entity Notes defines its own `entity_note` content entity (a fieldable, publishable, translatable, revisionable note with a required `note` body plus `entity_id`/`entity_type_id` back-references and an author). On its settings form (`/admin/structure/entity_note/settings`) you tick which entity types should have notes; the module then dynamically adds a `{entity}/notes` route and a local-task tab to every canonical page of those entity types. That tab renders a Views listing of the notes recorded for that specific entity and an inline "Add new note" form. Notes are also full entities with their own canonical/edit/delete pages, a Field UI base route (so you can add extra fields), and six granular permissions. Because listings are built with Views, teams can re-theme, sort and column-tune how notes appear.

---

- Add internal editorial notes to nodes (for example "needs legal review" or "update after launch").
- Keep admin notes on user accounts via a notes tab on the user profile.
- Attach handling notes to Drupal Commerce orders.
- Record per-entity reminders that live alongside content but are not part of public output.
- Enable notes only on the specific entity types you choose from the settings form.
- Give a team a shared place to record context about a piece of content.
- Let a single editor jot private working notes against the content they manage.
- Add extra fields to notes through the Field UI (notes are fieldable) to capture structured metadata.
- Re-theme the notes listing by editing the shipped `entity_notes` View.
- Control who can add, view, edit or delete notes with the module's six permissions.
- Separate published from unpublished notes using the publish/unpublish state.
- Track when a note was created and last changed via the built-in timestamp fields.
- Attribute each note to its author (the current user is recorded on creation).
- Show notes in the site's content language via the entity's translatable fields.
- Sort the per-entity notes table by change date out of the box.
- Add a note to a term, media item, or any other content entity type, not just nodes.
- Give reviewers a lightweight annotation workflow without adding comment threads.
- Surface a "No notes found." empty state when an entity has no notes yet.
- Paginate long note lists (the master display pages at 10 per page).
- Link editors straight to a note's edit or delete form from the listing's operations column.
- Use notes as an internal changelog attached to a specific entity.
- Capture QA or content-audit findings against individual entities.
- Store approval sign-offs next to the content they approve.
- Let support staff annotate customer accounts or orders.
