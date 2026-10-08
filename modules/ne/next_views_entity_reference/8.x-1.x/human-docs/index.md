# Next Views Entity Reference — manual setup guide

**Next Views Entity Reference** (`next_views_entity_reference`) adds a navigation
block that gives you **next / previous ("prior") links** between related nodes —
without needing the Book module or explicit entity‑reference fields on each node.
It is ideal when a set of nodes share a relationship, such as a common taxonomy
term, and you want visitors to page through them in sequence.

The sequence is driven by an **entity reference View**. Because the ordering comes
from a View, you can sequence nodes by any attribute the View can sort on — a
weight field, a taxonomy term, publication date, and so on — and the View can even
read arguments from the current URL. That makes it possible to present *different*
navigation for the same node depending on how it was reached. A classic example is
an article tagged into several digital issues: the same article can show a
different table of contents and different next/prior links depending on which
issue's URL the visitor followed.

The block works by finding the current node's ID within the list of IDs the View
returns; the next and prior nodes are simply the IDs before and after it. A fully
configured block shows a table of contents link at the top (typically the node
title linking to the node), with prior/next arrows below and the linked
neighbouring titles beside them. You can place the block in more than one location,
and each placement keeps its own settings. It depends on core **Views** (and the
**Twig Tweak** module), and the sequence always respects the View's access checks.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Views/Twig Tweak dependencies.

There is **no central configuration page** — you configure each placement of the
navigation block directly in **Block layout**, described in "How to use it" below.

## How to use it

1. Build (or reuse) an **entity reference View** that returns, in the order you
   want, the nodes you wish to page through — for example all nodes sharing a
   taxonomy term, sorted by a weight field. Contextual filters / arguments can
   read values from the URL so the sequence adapts to context.
2. Go to **Structure → Block layout** (`/admin/structure/block`) and click
   **Place block** in the region where the navigation should appear.
3. Choose the **Next Views Entity Reference** navigation block and point it at the
   View that supplies the sequence. Configure which elements to show — the table
   of contents link, the prior/next arrows, and the neighbouring titles.
4. **Save** the block. On any node that appears in the View's list, visitors can
   now click the arrows or the neighbouring titles to move to the next or prior
   node in the sequence.

Because each placement stores its own settings, you can add multiple navigation
blocks driven by different Views if you need more than one sequence on a page.
