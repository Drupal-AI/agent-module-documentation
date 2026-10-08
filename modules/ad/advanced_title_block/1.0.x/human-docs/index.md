# Advanced Page Title Block — manual setup guide

**Advanced Page Title Block** (`advanced_title_block`) provides a configurable
**page-title block** for building richer page headers — the kind of styled banner
or "hero" title you see at the top of a page — without writing custom theme code.
Instead of the plain page title, it renders the title with extra options: some
**copy text** alongside it, and a **background image** that is either fixed (one
image you choose) or **inherited from the node** (for example the node's own image
field), so each page's banner can pull its background from its own content.

It is a straightforward content-display / site-building block. The title and
background come from content and configuration, rendered through Drupal's normal
layers; it plays no access-control role. It depends on Drupal core's **Block** and
**Image** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Advanced Page Title Block adds a block that you place through Drupal's block
system under **Structure → Block layout** (`/admin/structure/block`). It has no
separate settings page of its own — all of its options live in the block's own
configuration form when you place or edit it.

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region where you want the page header to appear
   (usually a header or "content top" region), and choose the **Advanced Page
   Title Block**.
3. In the block's configuration form, set its options:
   - the **copy text** to show with the title,
   - whether the **background image** is a **fixed** image you upload/choose, or is
     **inherited from the node** (pulled from the node's image field).
4. Set the block's normal visibility settings if you only want it on certain pages,
   then **Save block**.

The block then renders a styled title banner on the pages where it is placed,
pulling its background from your chosen source.
