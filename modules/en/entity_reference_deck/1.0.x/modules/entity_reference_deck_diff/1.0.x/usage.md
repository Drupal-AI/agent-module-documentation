<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Deck Diff adds a card toolbar action and an AJAX modal that show a revision comparison of the referenced entity using the Diff module.

---

This feature submodule of Entity Reference Deck integrates the contrib Diff module into deck cards. It registers a 'diff' action plugin (DiffEntityReferenceDeckAction) whose button opens the entity_reference_deck_diff.dialog route in a modal dialog, reusing Diff layout plugins (including the shipped ErdeckSplitFieldsDiffLayout) so editors compare two revisions inline instead of leaving for Diff's full admin page. A dedicated access check (EntityReferenceDeckDiffDialogAccess) confirms the acting user can view the entity and both revisions, and that both revisions belong to the entity. Enable it after entity_reference_deck when the Diff module is present.

---

- Compare two revisions of a referenced entity from its deck card.
- Open the comparison in an AJAX modal dialog instead of a full admin page.
- Reuse Diff's field-level comparison layouts inside the deck UI.
- Give editors a quick diff of draft vs published content while editing references.
- Show a split-fields diff via the shipped erdeck_split_fields layout.
- Fall back to Diff's built-in split_fields layout when the custom one is unavailable.
- Restrict the diff dialog to users who can view the entity and both revisions.
- Add revision-compare capability to Entity Browser deck widgets.
- Add revision-compare capability to Paragraphs deck widgets.
- Enable or reorder the diff action from the global settings form.
- Review moderation drafts by diffing them against the default revision.
- Audit content changes without navigating away from the edit form.
- Surface changes to a referenced media or content item at a glance.
- Provide a consistent compare button across all deck host widgets.
- Localise the diff to the entity's current language when a translation exists.
- Let editors spot unintended edits before saving a reference field.
- Support any revisionable content entity type as a diff target.
- Keep the Diff chrome (layout/filter nav) out of the modal for a clean view.
- Show a friendly alert if the comparison cannot be built.
- Combine with the Moderation submodule for a draft-review workflow.
