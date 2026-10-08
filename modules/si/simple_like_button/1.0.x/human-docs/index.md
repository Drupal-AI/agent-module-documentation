# Simple Like Button — manual setup guide

**Simple Like Button** (`simple_like_button`) adds an AJAX‑powered "Like" button to
the entity shown on the current page. Logged‑in visitors click it for instant
feedback — the count goes up (+1) or down (‑1) without a page reload — and the button
toggles between **Like** and **Liked** depending on whether the current user has
already liked that content. It also shows a "Liked by:" list of the people who liked
the entity, with a marker highlighting the current user. It is a lightweight social‑
proof signal for articles, products, or any entity, without pulling in a full voting
framework.

The button is delivered as a **block** that you place through Drupal's core Block
layout UI. It automatically detects the entity in the current route, so once placed
in a region that appears on entity pages (for example the content region on node
canonical pages), it renders the like control for that entity. It works with all
entities and bundles, and for all authenticated roles. Anonymous users deliberately
see **no** button, and the block simply does not render on pages that have no entity
in the route.

A few things to know about how it behaves and stores data. Likes are saved as
`simple_like` **content entities** (in a `simple_like` database table, with fields
for the entity type, entity id, bundle, user id, and status), so they are queryable
for basic engagement analytics, and each user can like a given entity at most once.
Liking is limited to authenticated users, and because the like/unlike form is a
standard Drupal form it carries Drupal's CSRF token protection. There are two current
limitations to be aware of: the module is **not compatible with Views** at the
moment, and the button is **not shown to anonymous users**. Because the block is
user‑specific, Drupal bypasses caching for the like submission automatically — but if
you run aggressive reverse‑proxy caching, make sure authenticated traffic is handled
so the form can submit and update.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

The module has no settings form of its own; you get it working by placing its block:

1. **Enable the module** (see [Installation](installation/index.md)).
2. Go to **Administration → Structure → Block layout**
   (`/admin/structure/block`).
3. Place the **Simple Like Button** block in a region that appears on your entity
   pages — for example the **Content** region, below the main content.
4. Optionally, use the block's **Visibility** settings to limit it to the specific
   pages or entity types where a like button makes sense.

The like button now appears for authenticated users on pages that show an entity
(such as nodes). Clicking it creates a like row for that user and entity; clicking
again removes it (an unlike). If the button does not appear, confirm you are viewing
an actual entity route, that you are logged in, and that the block is placed in a
visible region. If AJAX does not update, check that session cookies are present and
that a reverse‑proxy cache is not interfering.

You can target the block region or the form (HTML id `like-form`) with CSS to adjust
the layout, and the button's styling comes from the shipped `simple_like_button/like`
asset library. If your theme hides block titles by default, check the block's title
settings suit your layout.
