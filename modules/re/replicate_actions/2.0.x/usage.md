Replicate Actions extends the Replicate / Replicate UI modules so that a cloned entity is created unpublished (or in a draft moderation state), owned by the current user, added to the same Groups as the original, and opened directly in its edit form.

---

The module hangs a set of event subscribers off Replicate's `REPLICATE_ALTER` and `AFTER_SAVE` events plus a `hook_form_alter` on the replicate confirm form. On replication it: sets the clone **unpublished** — or, when Content Moderation applies to the entity, sets `moderation_state` to `draft` (or the workflow default, governed by the `follow_default_moderation_state` setting) — and refreshes its created/changed timestamps (`ReplicateSetUnpublished`); sets the clone's owner to the **current user** (`ReplicateSetAuthor`); and, if the Group module is present, re-adds the cloned node to every Group the original node belonged to, supporting both Group 2.x (`group_content`) and 3.x (`group_relationship`) (`ReplicateNodeToGroup`). Paragraph entities and non-reusable (Layout Builder) block_content are deliberately left published. A submit handler on the replicate form (`ReplicateFormAlter`, wired through `ReplicateActionsHooks::formAlter` for form ids containing `_replicate_form`) redirects to the cloned entity's `edit-form` so an editor lands straight in edit mode. The only configuration is a single checkbox at `/admin/config/content/replicate/actions` (permission `administer site configuration`). (Note: the class `ReplicateSetEntityEdit` exists but is not registered as a service, so its redirect/unpublish variant is inactive; the active redirect comes from the form submit handler.)

---

- Make every replicated node start life unpublished so editors review before it goes live.
- Put cloned content into the Content Moderation `draft` state instead of publishing it immediately.
- Optionally follow the workflow's configured default moderation state instead of forcing draft.
- Reassign the clone's authorship to whoever performed the duplication.
- Reset created/changed timestamps on the clone to the moment of duplication.
- Automatically add a cloned node to the same Group(s) as the original.
- Support both Group 2.x and Group 3.x relationship entities when re-adding to groups.
- Send the editor straight to the clone's edit form after duplicating (fewer clicks than view-then-edit).
- Keep replicated Paragraphs published (they are intentionally exempt from unpublishing).
- Keep non-reusable Layout Builder block_content published while unpublishing reusable ones.
- Duplicate a complex page and immediately tweak it before publishing.
- Provide a safer "Save as new / duplicate" workflow on top of Replicate UI.
- Ensure moderated content never accidentally publishes on clone.
- Clone campaign/landing nodes into draft for A/B variants.
- Hand a duplicated node to a content manager pre-set to draft and owned by them.
- Preserve group membership when spinning up a copy of group content.
- Apply the draft-on-clone behaviour across any publishable content entity type, not just nodes.
- Fall back to plain unpublish when Content Moderation is not installed.
- Reduce editorial steps introduced by Replicate's default publish-and-view behaviour.
