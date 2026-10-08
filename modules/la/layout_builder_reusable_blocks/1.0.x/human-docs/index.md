# Layout Builder Reusable Blocks — manual setup guide

**Layout Builder Reusable Blocks** (`layout_builder_reusable_blocks`) lets editors
create and edit **reusable content blocks** without leaving the core **Layout
Builder** interface. Core offers two kinds of block: *inline* blocks, which belong
to a single layout and cannot be reused, and *reusable* content blocks from the
library, which can be placed anywhere but must be created and edited over at
`/admin/content/block`. That split forces a context switch at exactly the wrong
moment — an editor building a page realises a callout should be shared, and has to
leave the page, create it elsewhere, come back and place it. Editing is worse:
seeing a reusable block on the page and having to hunt for it in the library to
change a word.

This module closes that gap. "Make this reusable" and "edit this shared block"
become in‑place operations inside Layout Builder. It depends on core Layout Builder
and the core **Block content** module, and targets Drupal 10 and 11.

There is one consequence worth being deliberate about, because it is exactly what
the library's separation was protecting against: **editing a reusable block from one
page changes it on every page that uses it.** An editor who thinks they are
adjusting this page may change twenty. Whether that matters depends on your site,
but it is worth pairing this module with a clear visual distinction between inline
and reusable blocks, and with restricting who may edit shared blocks. The module's
own permission, **Administer layout builder reusable blocks**, is *restrict access*
and governs the module's settings — day‑to‑day block editing still follows normal
block content access.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the module's settings form and its
   restricted permission.

## Where it lives in the admin menu

The module's settings form sits at **Configuration → User interface → Layout
Builder Reusable Blocks** (`/admin/config/user-interface/layout-builder-reusable-blocks`).
The reusable‑block features themselves appear inside the Layout Builder editing UI —
when adding or editing blocks in a layout — once the module is enabled.
