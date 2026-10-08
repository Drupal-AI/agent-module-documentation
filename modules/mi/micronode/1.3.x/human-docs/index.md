# Nodes as Micro-content — manual setup guide

**Nodes as Micro-content** (`micronode`) lets you flag any content type as
"micro‑content" — content that only makes sense *embedded* inside other content (a
card, a callout, a reusable snippet) rather than viewed as its own page. Once a
type is flagged, its nodes are no longer reachable on their own canonical
`/node/{id}` page by ordinary visitors (editors who can update them still can), and
they're pulled out of the places that would otherwise clutter up with them: the
"Add content" chooser, admin content lists, newly created Views, and entity
reference autocompletes.

The appeal is that these stay **real nodes** — with fields, revisions, and
translations — so you get a proper component library of embeddable building blocks,
without those blocks showing up as standalone pages or in listings. The author
positions it as a simpler, node‑native alternative to modules like Rabbit Hole or
Microcontent, and any content type can be marked micro‑content (or un‑marked) at any
point in a project.

Under the hood the "hiding" is a targeted access rule: for a flagged type, the
**view** operation is forbidden on the canonical route for anyone who can't
**update** the node. The node still renders perfectly well when embedded via a
reference field, a view, or a layout — it's only its own dedicated page that's
blocked. There's no central settings page; you flag each type right on its own edit
form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optional integrations.
2. [Configuration](configuration/index.md) — how to flag a content type as
   micro‑content, what changes when you do, and the one‑time re‑save caveat.

## Where it lives in the admin menu

There is no central configuration page. You mark a type as micro‑content on that
content type's own edit form — **Structure → Content types → *(your type)* → Edit**,
in the **Micro‑content settings** vertical tab. Flagged types also gain a dedicated
add page at `/node/add-microcontent`.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Edit the content type you want to treat as micro‑content and tick **Is
   micro‑content** in the Micro‑content settings tab (see
   [Configuration](configuration/index.md)).
3. Create your reusable nodes as usual — from the new **Add Micro‑Content** area —
   and embed them in other content via reference fields, views, or layouts.
4. If you use the "Is Micro‑content" Views filter, re‑save each existing content
   type once so the flag initializes (explained in
   [Configuration](configuration/index.md)).
