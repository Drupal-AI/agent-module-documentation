# TOC Filter — manual setup guide

**TOC Filter** (`toc_filter`) is a text-format input filter that turns a `[toc]`
token in your content into a hierarchical, clickable table of contents built
automatically from the page's heading tags (`<h1>`–`<h6>`). Drop `[toc]` into the
body of a long article, documentation page, or policy document, and readers get a
"On this page" jump-link index that stays in sync with the headings — no manual
anchor markup required.

The heavy lifting of parsing headings and rendering the list is delegated to the
**TOC API** module (a required dependency). TOC API defines named **TOC types** —
Default, Simple, Full, Full - Numbered, and so on — that control the markup,
which heading levels are included, and the CSS classes. TOC Filter simply lets you
pick one of those types per text format and inject the result where the `[toc]`
token sits.

The filter is flexible. You can auto-insert a TOC at the top or bottom of every
page in a text format without editing each node, exclude an intro section's
headings, or override the style for a single page with inline options like
`[toc type="simple" title="Contents"]`. A companion **"Table of contents"** block
can move the TOC out of the content flow and into a sidebar region, appearing only
on pages that actually have a TOC. Developers can implement
`hook_toc_filter_alter()` to tweak or suppress a TOC (for example, hide it on
pages with too few headings).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside TOC
   API and enable the module.
2. [Configuration](configuration/index.md) — enable the filter on a text format,
   its four settings, the `[toc]` token and its inline options, and the optional
   block.

## Where it lives in the admin menu

There are two places to look. You turn the filter **on** per text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`). The TOC **types** you choose between are managed
by TOC API at **Structure → Table of contents** (`/admin/structure/toc`) — this is
the module's listed `configure` route.

## How to use it

1. Enable the "Display a table of contents" filter on a text format (see
   [Configuration](configuration/index.md)).
2. Edit a piece of content using that format and add `[toc]` wherever you want the
   table of contents to appear.
3. Structure the content with real heading tags (`<h2>`, `<h3>`, …) — make sure the
   format's allowed-HTML filter permits them. TOC Filter builds the index from
   those headings.
4. Save and view the page. The `[toc]` token is replaced with a linked outline of
   the headings.
