# Next And Previous Link — manual setup guide

**Next And Previous Link** (`nextpre`) provides a configurable block that adds **"previous"**
and **"next"** links to a node's detail page, so visitors can move from one piece of content
to the next without going back to a listing. It's the classic "← Older / Newer →" post
navigation you see on blogs, and it works for any single content type you choose — news,
articles, case studies, documentation pages, events, and so on.

You place it like any block, through **Block layout**, and configure it right there on the
block. You pick one content type it applies to, set the button labels, and optionally add CSS
classes for styling. On a node page whose type matches, the block finds the neighbouring
nodes and renders up to two links. If the visitor is at the start or end of the range, the
missing link is simply left out.

The "previous" and "next" neighbours are chosen strictly by **node id** (creation order) —
previous is the nearest lower id, next is the nearest higher id — filtered to the same content
type, published nodes only, and the visitor's current language. That means navigation follows
the order content was created, which may differ from a date field or a manual ordering you
show elsewhere; if you need a different order, a View is the better tool. Because every setting
lives on the block instance, you can place several copies in different regions, each targeting
a different content type or using different labels. There is no global settings page and no
permissions; it depends on core's **Node** module.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

There is no central settings page — you configure everything on the block:

1. Go to **Structure → Block layout** and click **Place block** in the region you want (a
   sidebar, the footer, or a content region below the node).
2. Find **Next Previous link** (listed under the *Blocks* category) and place it.
3. On the block's configuration form, set:
   - **Content type** *(required)* — the single content type this navigation applies to.
     Options come from your site's node types.
   - **Previous text** *(required)* — the label for the previous link (for example
     "← Older").
   - **Next text** *(required)* — the label for the next link (for example "Newer →").
   - **Previous link class** *(optional)* — a CSS class for the previous link. If left empty
     it falls back to `btn`.
   - **Next link class** *(optional)* — a CSS class for the next link, also falling back to
     `btn`.
4. As with any block, you'll usually want to limit its visibility so it only shows on the
   relevant pages, then **Save block**.

Once placed, the block appears only on the canonical node pages of the chosen content type
and renders nowhere else. Each link also carries a `nextpre__btn` class alongside whatever
class you set, so you can style previous and next independently. The block's output
cache-invalidates whenever nodes are added or changed, so the navigation stays correct as
content grows.

For a multilingual site, place one block per language-aware need — the neighbour lookup is
scoped to the visitor's current language automatically.
