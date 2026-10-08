# Book Blocks — manual setup guide

**Book Blocks** (`book_blocks`) adds four configurable blocks for Drupal's core **Book**
module, each designed for building documentation-style sites. They all operate on the book page
currently being viewed — reading the current node's book outline and rendering nothing on
non-book pages — so you can place them once and they simply do the right thing as readers move
through a book.

The four blocks are: **Book Children Links**, which lists the child pages of the current page;
**Book Navigation Links**, which reproduces the prior/up/next links from the page bottom;
**Book Table of Contents**, which renders the book's full TOC with a link to the top page; and
**Book Edit Links**, a combined block that pulls navigation, TOC and edit links together and is
the most configurable of the set. The Edit block can show icons instead of text, include or
omit the TOC and navigation sections, use a display-style CSS preset, offer an editor-facing
"Add sibling page" link, and carry three custom left/middle/right links.

The blocks also emit `rel=prev/up/next` head links (useful for SEO and browser navigation) and
use book-aware cache contexts so their output varies correctly per page. The TOC block pairs
well with Collapsiblock for expand/collapse behaviour, though the Edit block has its own
built-in collapsible TOC without needing that module.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it
   (along with the Book module).
2. [Configuration](configuration/index.md) — placing the blocks and the Edit block's settings.

## Where it lives in the admin menu

Book Blocks has **no settings page of its own**. You place its blocks the usual way, via
**Structure → Block layout** or Layout Builder, and the one configurable block (Book Edit
Links) is configured in its block placement form. There are no permissions specific to this
module — the blocks are read-only navigation and respect existing content access.
