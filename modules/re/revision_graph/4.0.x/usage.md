<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Revision Graph adds a "Revision Graph" tab to every node, drawing its revision history as an interactive graph with one lane per language rather than as a reverse-chronological list.

---

Drupal's revision tab is a flat list, which is adequate while history is linear. Once a site uses content moderation with drafts alongside a published version, or translations that revise independently, history stops being a line — and a list cannot show that. Revision Graph draws it as a graph: one lane per language, a dot per (revision, language) pair, and edges that follow provenance. Each dot's glyph states the revision's role in its language's live history (live, current-but-unpublished, pending draft, historical); a workflow-state badge and node-wide bands ("default revision", "latest") sit alongside. In 4.0 the whole payload is served by a JSON items endpoint (`/node/{node}/revision_graph_items`) that the client pages through as the reader scrolls, and a standalone TypeScript renderer draws it. A new revisionable base field (`revision_graph_parent`) records where each save was derived from, so genuine forks and reverts are drawn from recorded provenance rather than inferred from revision-ID adjacency (run database updates after upgrading). Lane colours are configurable at Administration › Configuration › Content authoring › Revision Graph, gated by the new "administer revision graph" permission; every langcode ships a distinct default colour.

---

- See a node's revision history as a graph instead of a list.
- Understand a non-linear, multilingual revision history at a glance.
- Distinguish a language's live revision from a current-but-unpublished one.
- Spot pending drafts that were never the default revision.
- Find where a draft forked from the published version.
- Investigate a change that disappeared (reverted vs superseded vs lost in translation).
- Distinguish a recorded revert from an inferred edit chain (heavier "recorded provenance" edges).
- Trace each translation's separate revision line in its own lane.
- Read the node-wide default and latest revision from the header and bands.
- See per-revision workflow state (Draft, Published, Legal review) as a badge.
- Revert or set-as-current one translation without clobbering the others.
- Be warned before deleting a revision other branches descend from.
- Configure a distinct colour per language branch.
- Confirm who can view the revision graph (follows "view all revisions" node access).
- Audit revision history on sensitive content.
- Consume the revision graph JSON payload from another module or a standalone JS client.
- Explain history in an editorial dispute.
- Review moderation-workflow history for a node.
- Reconcile diverged revisions across languages.
- Train editors on revision and translation behaviour.
