# Content Dependency Graph — manual setup guide

**Content Dependency Graph** (`content_dependency_graph`) draws an interactive map
of how a piece of content relates to everything it points at — the media, taxonomy
terms, paragraphs, and other referenced entities that a node depends on. It's a
read‑only reporting and visualization tool: nothing on the screen changes your
content, it just helps you *see* the web of references before you act on it.

The graph is a force‑directed diagram (powered by the vis‑network library) with
nodes color‑coded by entity type — **Node** blue, **Paragraph** green, **Media**
purple, **Taxonomy term** orange, **File** red — each with an SVG icon. You can
zoom, fit‑to‑view, go fullscreen, drag to pan, and filter by entity type while the
root node always stays visible. Click any node in the graph and a sidebar shows
that entity's details and relationships. The graph traverses entity reference and
entity reference revisions fields recursively; to keep it meaningful it deliberately
skips metadata fields (like `uid`, `type`, `langcode`, `moderation_state`) and
internal entity types (users, roles, workflows, and so on), as well as views, menus,
and configuration dependencies.

This is a great tool for understanding editorial dependencies before you delete or
unpublish something, auditing which media or terms a page relies on, or spot‑checking
reference integrity after a migration. It works as soon as you enable it and grant
one permission — there is **no settings form**. It depends on core's Node, Taxonomy,
and Media modules and runs on Drupal 10.3+ and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and grant the permission.

This module has **no configuration page** — there is no settings form. The only
setup beyond installing is granting the **access content dependency graph**
permission, covered in the installation guide.

## Where it lives in the admin menu

The index page is at **Administration → Content → Dependency Graph**
(`/admin/content/dependency-graph`), which lists the 100 most recently changed nodes,
each linking to its own graph. You can also reach a specific node's graph directly at
`/admin/content/dependency-graph/{node_id}`, or open any node and click the
**Dependency Graph** tab that the module adds to the node's page.

## How to use it

1. Grant the **access content dependency graph** permission to the editorial roles
   that should be able to inspect content structure (see
   [Installation](installation/index.md)).
2. Go to **Content → Dependency Graph** and pick a node from the list of recently
   changed content — or open a node and click its **Dependency Graph** tab.
3. The selected node appears as the root, with all the entities it references fanning
   out around it. Click nodes to inspect them in the sidebar, use the entity‑type
   filter to focus on one kind of reference, and zoom, fit, or go fullscreen as
   needed.
