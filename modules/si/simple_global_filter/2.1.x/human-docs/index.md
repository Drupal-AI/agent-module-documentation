# Simple Global Filter — manual setup guide

**Simple Global Filter** (`simple_global_filter`) lets you put a single, site‑wide
filter on your Drupal site — a persistent selection, usually a taxonomy term, that
follows the visitor around and that other components can react to. Think of a
"showing content for: **Europe**" selector in the header that stays put as the
visitor moves between pages, quietly narrowing what blocks and Views display.

The filter is built on taxonomy, so you decide the dimension: region, category,
brand, audience — any vocabulary works. Once a global filter is set, its current
value persists across the visitor's session. You can expose it as a **block** for
visitors to change, drive it from **GET parameters** in the URL (so a filtered view
is shareable as a link, optionally with a tidy alias), use it as a **block
visibility condition**, integrate it with **Views** through a provided filter, or
read and set it **programmatically** from your own code. You can also choose whether
an "all items" option is offered, and whether it is the default.

It is important to understand what this filter does and does not do: it shapes what
is **displayed**, not what a visitor is **allowed** to see. Restricted content is
still governed by its own access rules — the global filter is a presentation and
selection layer sitting on top of normal access control, not a substitute for it.
The module depends only on core's **Taxonomy** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

After enabling the module you create one or more global filters and then decide how
visitors interact with them:

- **Expose it as a block.** Place the global‑filter block in a region (through
  **Structure → Block layout**) so visitors can change the current selection.
- **React to it in blocks.** Use the global‑filter condition in a block's
  **Visibility** settings to show or hide a block depending on the current value.
- **React to it in Views.** Add the provided global‑filter view filter to any View
  so listings narrow to the current selection.
- **Drive it from the URL.** Change the filter with GET parameters so a filtered
  state can be shared as a link; URL aliases keep those links readable.
- **Use it in code.** Any custom module can read or set the current global filter
  programmatically.

Because the module is in "maintenance fixes only" status and is seeking a new
maintainer, treat it as stable rather than actively growing, but it remains covered
by Drupal's security advisory policy.
