# Search API block — manual setup guide

**Search API block** (`search_api_block`) gives you a configurable **Search API
form** block: a lightweight search input you can drop into any region that sends
the visitor's keyword to a Search API search page. It's the natural replacement
for core's Search block, which doesn't work with Search API.

The important thing to understand is that this block does **not** run a search
itself. Instead, you point it at the path of an existing Search API view page
(for example `/search`) and tell it the machine name of that view's exposed
keyword filter (core's default is `keys`). When someone types a query and
submits, the block simply navigates to your search page with the keyword in the
query string — so your search results come from whatever backend the view uses,
be it the database, Solr, or Algolia.

The block's settings let you choose the submit method (GET keeps the query in a
shareable URL; POST keeps it out of the URL), a placeholder, the submit-button
label, an optional visible or screen-reader label, and whether to carry any
existing query parameters from the target path through as hidden fields. You can
place several blocks pointing at different search pages — products versus
articles, say — and restrict each with core's block visibility conditions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — place the block and set it up, field
   by field.

## Where it lives in the admin menu

There is no dedicated settings page. You place and configure the block from
**Structure → Block layout** (`/admin/structure/block`) — look for **Search API
form** in the block list (under the *Forms* category).

## How to use it

1. Make sure you have a **Search API view page** with an exposed keyword filter
   (this is your search results page).
2. Enable the module (see [Installation](installation/index.md)).
3. Place the **Search API form** block in a region and point it at your search
   page path and exposed filter name (see
   [Configuration](../configuration/index.md)).
4. Save. Typing a query into the block now takes visitors to your search results.
