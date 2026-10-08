# Sector Table of Contents — manual setup guide

**Sector Table of Contents** (`sector_toc`) automatically builds a table of
contents from a page's headings and shows it as a sidebar block beside long HTML
documents. It scans the `h2` and `h3` headings in a node's body field and turns
them into a navigable contents list, so readers can jump straight to the section
they want.

The problem it solves is orientation within long articles: instead of scrolling
endlessly, a visitor sees the document's structure in the sidebar and clicks to
navigate. The block also adds JavaScript that keeps the URL hash updated to
highlight the **active** heading as you scroll (using an Intersection Observer),
and it is careful to distinguish jumping to a heading because you clicked a
contents link from ordinary scrolling while reading.

It is a content-display / navigation feature; the table of contents simply
reflects the headings on a page the visitor can already see, and it has no
access-control role. You place a single block through Block Layout — there is no
separate settings form. It depends on the **Chunker** module and core **Block**,
and supports Drupal 10.3 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the **Table of Contents** block into a sidebar region beside your
   long-content pages.
3. On pages whose body field contains `h2` / `h3` headings, the block builds a
   contents list from those headings automatically. As the reader scrolls, the
   active heading is highlighted and the URL hash updates so links are shareable.

Because the list is generated from the page's own headings, there is nothing to
maintain by hand — structure your content with proper `h2`/`h3` headings and the
TOC follows.
