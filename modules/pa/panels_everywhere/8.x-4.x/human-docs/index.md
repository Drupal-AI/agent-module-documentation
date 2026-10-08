# Panels Everywhere — manual setup guide

**Panels Everywhere** (`panels_everywhere`) lets you arrange the **whole page** —
header, footer, sidebars, and content — through the Panels interface, rather than
just the content region. Normally a page's structure is a theme concern:
`page.html.twig` defines the regions, blocks are placed into them, and changing
the arrangement means editing a template. Panels Everywhere inverts that: the page
itself becomes a Panels **variant**, so the entire shell is a set of panes you
arrange in the same UI, and a different page arrangement is a different variant
rather than a different template. It can even take over the page theme so you no
longer need a `page.html.twig` at all.

It builds on Chaos Tools' **Page Manager** and the **Panels** module — this is the
Drupal 7-era architecture for controlling page structure with Panels. It requires
`panels`, `page_manager`, `ctools_block`, and core `layout_discovery`. This
release is **8.x-4.0-beta4**, a beta.

Two things need saying plainly before you adopt it:

1. **This is the Drupal 7 architecture, and core has moved elsewhere.** Core's
   answer to the same question is **Layout Builder**, which is core-maintained and
   where the ecosystem's attention is, while Panels and Page Manager remain in
   long-running beta. Panels Everywhere really belongs to sites that already use
   it, not to new builds — a new project choosing it is choosing a path with a
   smaller and shrinking community.
2. **Taking the page shell away from the theme has consequences worth checking.**
   Anything that assumes the theme's regions — a contrib module placing a block, a
   theme's own preprocess code, the admin **toolbar**, **status messages** — needs
   verifying rather than assuming, because those assumptions are exactly what the
   inversion breaks.

Where it is coherent: teams whose page structures vary a great deal, or who want
**site builders** rather than front-end developers making those decisions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install Panels, Page Manager, and
   Panels Everywhere with Composer, and enable them.
2. [Configuration](configuration/index.md) — set up the site template page
   variant that wraps every page.

## Where it lives in the admin menu

Panels Everywhere has no standalone settings form. You configure it through
**Page Manager** at **Structure → Pages** (`/admin/structure/page_manager`),
where it adds a **site template** page whose variants define the full-page
layout. See [Configuration](configuration/index.md).
