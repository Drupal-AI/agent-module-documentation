# Search API Pages — manual setup guide

**Search API Pages** (`search_api_page`) gives you standalone search pages —
each one served at its own URL and backed by a Search API index — without having
to build a search View by hand. If you have a Search API index already set up
(database, Solr, or otherwise), this module lets you point a friendly search
page at it in a couple of minutes, and drop a matching search box block wherever
you like.

Each search page is a small configuration entity that binds one index to one
URL path (for example `search/content`). When a visitor types keywords, the page
runs a Search API query against that index over the fields you chose, and renders
the matches — either as fully rendered entity teasers or as compact excerpt
"snippets" with highlighted terms — complete with a pager. You control the
results-per-page limit, whether the URL uses clean path-based keys or a query
string, whether all results are listed before any search is run, and how the
keyword string is parsed.

The module also ships a **search form block** you can place in any region; its
submissions redirect to the search page you choose. And because every page is
exposed to Search API as a "display" plugin, you can layer Facets and other
display-aware features on top of an individual page.

Its only hard dependency is **Search API** itself — you must have at least one
index for a page to bind to.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create and tune search pages, place
   the search-form block, and the permissions involved.

## Where it lives in the admin menu

Search pages are managed at **Configuration → Search and metadata → Search API
Pages** (`/admin/config/search/search-api-pages`). Each page you create then
serves its own front-end URL at the path you gave it.

## How to use it

1. Make sure you have a **Search API index** already built (see the
   [installation notes](installation/index.md#requirements)).
2. Go to **Configuration → Search and metadata → Search API Pages** and click
   **Add search page**.
3. Give it a label and a path, pick the index to search, and adjust the display
   options (see [Configuration](configuration/index.md)).
4. Optionally place the **Search Api Page search block form** block in a region
   and point it at your new page.
