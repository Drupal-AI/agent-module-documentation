# Floating Sticky Notes — manual setup guide

**Floating Sticky Notes** (`floating_sticky_notes`) gives your site simple,
interactive sticky notes that float over the page. Once you place its block, a
sticky-notes icon appears; clicking it opens a panel where users can create, edit,
and save notes that stay available for later. The notes are draggable on-screen
widgets — handy for reminders, internal annotations, or on-screen prompts. There is
also a dedicated listing page at `/admin/content/sticky-notes` where all created
notes can be reviewed from one place.

Setup is done through Drupal's normal building blocks rather than a dedicated
settings form: you place a **block** to expose the feature, and you use
**permissions** to control who can work with notes. It depends on core's Block
module and on the jQuery UI module for the drag behaviour.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no dedicated settings form** — you set the module up by placing its
block and assigning permissions, described in "How to use it" below.

## Where it lives in the admin menu

You place the Sticky Notes block from **Structure → Block layout**, manage who can
use it under **People → Permissions**, and review all notes at **Content → Sticky
notes** (`/admin/content/sticky-notes`).

## How to use it

1. **Place the block.** Go to **Structure → Block layout**
   (`/admin/structure/block`), find the **Sticky Notes Block**, and place it in the
   region of your theme where you want the sticky-notes icon to appear. Save the
   block configuration.
2. **Set permissions.** Under **People → Permissions**
   (`/admin/people/permissions`), grant the Floating Sticky Notes permission(s) to
   the roles that should be able to create and manage notes.
3. **Create and manage notes.** With the block placed, a sticky-notes icon appears
   on the page. Click it to open the notes panel, then create, edit, and save
   notes. Saved notes remain available for future visits.
4. **Review all notes.** Visit **Content → Sticky notes**
   (`/admin/content/sticky-notes`) to see every note created on the site in one
   listing.
