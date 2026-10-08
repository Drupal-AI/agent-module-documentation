# Configuration

Lunr is configured through **Lunr search** entities. Each entity defines what is
indexed, how the index is boosted, and the search page that visitors use. Unlike
most modules, Lunr consolidates settings that other search tools split across
index/page/server into a single form and entity, which keeps setup simple.

> **Before you index anything, remember the public‑index rule.** Whatever you add
> to a Lunr index is served to the browser in full and is readable by anyone who
> loads the search page — there is no access check when a search runs. Only index
> content that is safe to be public, and leave unpublished or restricted content,
> and any non‑public fields, out of the index.

## Where the settings live

Lunr search entities are managed under **Configuration → Search and metadata**,
at paths beginning `/admin/config/lunr_search`. You need the appropriate Lunr
permission (the module provides its own) plus the ability to administer the
Views that back the index.

## Using the default search entity

If the **Node** module was enabled before you installed Lunr, a default search
entity already exists. To get searching immediately:

1. Go to `/admin/config/lunr_search/default/index`.
2. Click **Index**. Lunr builds the pre‑compiled JSON index from the entity's
   configured View.
3. Visit the search page at `/search` and try a query.

## Creating a new Lunr search page

To build a search page from scratch, create a new Lunr search entity and point it
at the content you want searchable. Lunr uses **Views** under the hood to select
and transform the data that goes into the index and to render result pages, so
you have the full flexibility of Views for filtering, fields, and formatting.
The Drupal.org handbook page "Creating a Lunr search" walks through this in
detail.

Once the entity is defined, open its **Index** operation and build the index, the
same way as for the default entity above.

## Field boost

Lunr lets you tune **field boost** through the UI — how much weight each indexed
field carries when scoring results. Raise the boost on the fields that should
dominate relevance (a title, say) and lower it on supporting fields so a keyword
match in the title ranks above the same keyword buried in the body.

## Facets and field searches

Custom field or facet searches can be performed either through the search form or
via URL query parameters. The optional **Lunr Facet Example** submodule provides
a working reference you can copy from. Multilingual support needs no
configuration — Lunr builds indexes for all installed languages automatically.

## Deployment for static sites

The index Lunr builds lives in the `public://lunr_search` directory. When you
deploy a **static** copy of the site, include that directory so the pre‑built
index ships alongside the pages. If you use **Tome**, these files are included in
the export automatically — no extra step needed.

## Re‑indexing

Whenever the indexed content changes and you want the search to reflect it,
return to the entity's **Index** operation and rebuild. For automated or
command‑line workflows, Lunr also ships a Node.js indexing script; see the
module's README for details.
