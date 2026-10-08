# Taxonomy Term Replace — manual setup guide

**Taxonomy Term Replace** (`taxonomy_term_replace`) gives you an admin dashboard for a
common but tedious job: swapping one taxonomy term for another across all the nodes
that reference it. Pick a vocabulary, choose the term you want to get rid of and the
term you want to use instead, and the module reassigns every matching node in bulk —
no editing pages one at a time.

Along the way it answers two questions site builders often have. First, "how many
nodes actually use this term?" — the dashboard searches and lists the associated nodes
(with their id, link, content type, and published status) so you can see the impact
before you commit. Second, "can I get that as a report?" — a **Download table** button
exports the list to a CSV file. You can include unpublished nodes in the search, and
you can select just some of the listed nodes rather than replacing on all of them.

This is the safe, UI-driven way to merge duplicate tags, retire a deprecated category
by moving its content to a successor, or free up a term for deletion by moving its
content elsewhere first. Under the hood the replacement runs as a batch that rewrites
each node's term reference from the old term id to the new one and saves the node —
the rest of the node is untouched.

This guide is written for a **human**. For a terse, token-cheap reference aimed at an
AI coding agent — including how nodes are located and the replacement semantics — read
the sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and grant
   the dashboard permission.

This module has no settings to configure; it is a single dashboard workflow, described
below.

## How to use it

1. Grant the **Access Taxonomy Term Replace dashboard** permission
   (`access Taxonomy Term Replace dashboard`) to the roles that should use the tool,
   at **People → Permissions** (`/admin/people/permissions`).
2. Go to **Structure → Taxonomy** and open the **Taxonomy Term Replace** dashboard
   (`/admin/structure/taxonomy/taxonomy-term-replace`) — it is linked from the
   vocabulary list.
3. Select a **vocabulary**, then the **target term** (the one to replace) and the
   **replacement term** (both from that vocabulary).
4. Optionally tick **Add unpublished nodes**, then click **Search** to list the nodes
   that reference the target term.
5. Optionally click **Download table** to export that list as a CSV.
6. Select the rows you want and click **Process replacement**. A batch runs through
   the selected nodes, swapping the target term for the replacement term on each.

Published nodes are found via Drupal core's taxonomy index; including unpublished
nodes makes the module scan each content type's entity-reference fields for matches.

## Where it lives in the admin menu

The dashboard sits under **Structure → Taxonomy**, at
`/admin/structure/taxonomy/taxonomy-term-replace`, linked from the taxonomy
vocabulary list. It is gated by the module's own **Access Taxonomy Term Replace
dashboard** permission.
