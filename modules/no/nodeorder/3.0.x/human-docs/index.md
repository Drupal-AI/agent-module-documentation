# Node Order — manual setup guide

**Node Order** (`nodeorder`) lets editors **drag and drop the order of content
within a taxonomy term**. Out of the box, a term's listing page shows its nodes in
whatever order Drupal decides (usually newest first). With Node Order you can
instead put content in a deliberate, hand-picked sequence — a featured article
first, a "Getting started" guide at the top of a category, products arranged the
way a merchandiser wants them.

You switch it on per vocabulary: mark a vocabulary as **Orderable**, and each of
its terms gains an **Order** tab with a drag-and-drop list of the content filed
under that term. Drag the rows, save, and the positions stick. Behind the scenes
the positions are stored as a weight against each node/term pairing (a column the
module adds to core's taxonomy index), so ordering is fast and doesn't require any
extra fields on your content.

Because the order is exposed to **Views** as a sort, you can build listings that
honor the manual order anywhere — the built-in taxonomy term page, a custom block,
or a full Views page. Two permissions control who can do what: one for editors who
arrange content, and one for administrators who decide which vocabularies are
orderable in the first place.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — make a vocabulary orderable, tune the
   display options, order the nodes, and sort a View by the manual order.

## Where it lives in the admin menu

- Its settings form is at **Configuration → Content authoring → Node Order**
  (`/admin/config/content/nodeorder`).
- You can also mark a vocabulary orderable from the vocabulary's own edit form under
  **Structure → Taxonomy** (`/admin/structure/taxonomy`).
- Ordering itself happens on each term's **Order** tab at
  `/taxonomy/term/{term-id}/order`.
