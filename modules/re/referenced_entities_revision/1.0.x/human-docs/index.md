# Referenced Entities Revision — manual setup guide

**Referenced Entities Revision** (`referenced_entities_revision`) adds a
**"Revision List" tab** to node pages that shows, in one combined table, the
revisions of the node *and* the revisions of every node it references —
recursively. If you build landing pages or composite content out of many
referenced child nodes, this saves you from opening each referenced node one by
one just to review its history.

When you open the tab on a node, the module walks that node's
`entity_reference` and `entity_reference_revisions` fields (following node targets
only, and following them recursively), gathers every reachable node's revisions,
and renders them as a single sorted table — newest first. Each row shows the
title, item type, the user who created the revision, the node ID and revision ID,
and the changed timestamp. Each row also links to **View** that specific revision
and to **Revert** to it (via Drupal core's own access-checked revision-revert
confirmation form).

The module defines no permission of its own: the tab and its links are gated by
core's **View all revisions** permission, and reverting goes through core's normal
access-checked flow. There is no settings page and nothing to configure — enable
the module, grant the permission, and the tab appears.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permission.

There is **no configuration page** for this module — it has no settings form. Its
only setup is the **View all revisions** permission, described below.

## Where it lives in the admin menu

Referenced Entities Revision adds no page under the admin configuration menu.
Instead it adds a local task **tab** on node pages. Open any node and look for the
**Revision List** tab (alongside View / Edit / Delete / Revisions); it lives at
`/node/{nid}/revisionList`.

## How to use it

1. Grant the core **View all revisions** permission to the roles that should see
   the tab, at **People → Permissions**
   (`/admin/people/permissions`). Without it, the tab is not accessible.
2. Open a node that references other nodes.
3. Click the **Revision List** tab.
4. You'll see a combined table of every revision of that node and of the nodes it
   references, sorted newest first. Use the **View** link on any row to open that
   revision, or the **Revert** link to roll back to it through core's confirmation
   form.

This is especially useful on "parent" nodes that pull together many child nodes —
for example a landing page assembled from referenced sections — where you want to
confirm that referenced content changed at the same time as its parent, or audit
who changed what across the whole reference tree.
