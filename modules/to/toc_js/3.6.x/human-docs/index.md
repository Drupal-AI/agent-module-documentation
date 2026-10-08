# Toc.js — manual setup guide

**Toc.js** (`toc_js`) automatically builds a **table of contents** from the
headings on a page — entirely in the browser, on the client side. Point it at
your content, tell it which heading levels to include (by default `h2` and
`h3`), and it generates a clickable, nested list of links that jump to each
section, with niceties like smooth scrolling and highlighting the current section
as the reader scrolls.

There are two ways to place a table of contents. You can turn it on **per content
type**, so every node of that type gets a TOC as an extra display field you
position on the Manage display page. Or you can place the **Toc.js block** in any
region (a sidebar, for instance) to build a TOC for whatever page is showing.
Both share the same rich set of options.

Because the TOC is generated in JavaScript from the rendered headings, it needs
no special markup in your content — just normal headings. Two optional submodules
extend it: a text-format **filter** for embedding a TOC inside body text, and a
**per-node** option that lets editors toggle the TOC on individual nodes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — the table-of-contents options, so
   you can tune the title, which headings are included, scrolling behavior, and
   more.

## Where it lives in the admin menu

Toc.js has no single settings page. Its options appear in two places:

- On each content type's edit form, in a **Table of contents** section under
  *Additional settings* — **Structure → Content types → (your type) → Edit**
  (`/admin/structure/types/manage/<type>`).
- In the **Toc.js block**'s configuration form when you place the block via
  **Structure → Block layout** (`/admin/structure/block`).

## How to use it

**Option A — a TOC on every node of a content type.**

1. Edit the content type and open the **Table of contents** section (you need the
   *Administer Toc.js* or core *Administer nodes* permission).
2. Tick **Enable Table of contents** and adjust the options (see
   [Configuration](configuration/index.md)).
3. Save, then go to that type's **Manage display** and place the **Toc** field
   where you want the table of contents to appear.

**Option B — a TOC block.**

1. Go to **Structure → Block layout** and place the **Toc.js block** in a region.
2. Configure its options in the block form (the same options as above).
3. Save the block.

Either way, once the page loads the module reads your headings and builds the
table of contents in the browser.
