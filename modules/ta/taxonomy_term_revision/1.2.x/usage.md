<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Taxonomy Term Revision gives taxonomy terms the revision UI nodes have had for years: a Revisions tab listing every saved version, with view, revert and delete operations, plus a revision log message field and content moderation support.

---

Core stores taxonomy term revisions but exposes almost nothing for working with them. This module fills in the missing pieces with four small hooks and three routes. `hook_entity_base_field_info_alter()` makes the term's existing `revision_log_message` field visible and editable — labelled *Revision log message*, revisionable, rendered as a four-row textarea at weight 25 on the term form. `hook_entity_presave()` forces **every** term save to create a new revision, stamping the current user and request time; there is no per-bundle toggle, so once the module is enabled, terms behave like always-revisioned entities. `hook_entity_type_alter()` sets the taxonomy term entity's `moderation` handler to `ModerationHandler`, enabling content moderation workflows on terms, which core leaves off. The UI is `/taxonomy/term/{term}/revisions` (a revisions table), `/taxonomy/term/{term}/revision/{revision_id}` (view a revision, gated by ordinary term view access), and confirm forms for revert and delete. Four permissions gate the operations: `view term revision list`, `view term revision data`, `revert term revision` and `delete term revision`.

---

- Give editors a revision history for taxonomy terms.
- Revert a term to a previous version after a bad edit.
- Delete an unwanted term revision.
- Record why a term was changed with a revision log message.
- Audit who changed a term and when.
- Apply content moderation workflows to taxonomy terms.
- Track changes to a controlled vocabulary over time.
- Review a term's wording before publishing a change.
- Restore a term description that was overwritten.
- Compare how a category label evolved.
- Meet an audit requirement for taxonomy changes.
- Give term editing the same safety net as node editing.
- Let a reviewer see the previous version of a term.
- Keep an editorial trail for regulated vocabularies.
- Roll back a bulk vocabulary edit gone wrong.
- Grant revision viewing without granting revert rights.
- Restrict revision deletion to administrators.
- Support moderation states on terms used for navigation.
- Encourage editors to explain vocabulary changes.
- Investigate when a term's description changed.
