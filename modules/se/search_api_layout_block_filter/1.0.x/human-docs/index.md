# Search API Layout Block Filter — manual setup guide

**Search API Layout Block Filter** (`search_api_layout_block_filter`) fixes a
common false-positive problem in full-text search on Layout Builder pages. Search
API can index the *rendered* content of a page, which is powerful: it captures
text that lives in blocks placed on a layout rather than in a field on the entity.
But it captures *everything* on the page — including blocks that have nothing to
do with the page's real subject.

The classic example: an article about burgers has a "related articles" slider,
and one of those related cards happens to be titled "Pizza". When Search API
indexes the rendered article, the word "Pizza" from the slider gets indexed as
though it were part of the burger article — so a search for "Pizza" surprises
everyone by returning the burger page. This module lets you tell Search API:
"when you index this page's rendered content, ignore that related-articles
slider." You pick which indexes it applies to and which Layout Builder blocks
should be stripped out before the page is rendered for indexing.

The module depends on the **Search API** and core **Layout Builder** modules, and
it defines its own permission for reaching the configuration form. It affects only
what gets indexed — it has no wider access-control role. Note that it takes effect
on *newly indexed* content, so you need to re-index after configuring it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose the indexes and the blocks to
   exclude, then re-index.

## How to use it

Once enabled, open the module's configuration form, tick the indexes you want it
to work on and the Layout Builder blocks that should be excluded, enable the
filter, and save. Then re-index your content so the cleaner indexed text takes
effect. See [Configuration](configuration/index.md) for the details.
