# Search API HTML Element Filter — manual setup guide

**Search API HTML Element Filter** (`search_api_html_element_filter`) adds a
Search API processor that strips unwanted HTML elements out of your content
*before it is indexed* — and, optionally, out of rendered search results too. If
your indexed pages carry menus, sidebars, advert blocks, breadcrumbs or "related
content" widgets that keep polluting your search, this is the tool that removes
them.

It ships a single processor plugin, **HTML Element Filter**. You add it to a
Search API index and give it a list of **CSS selectors** — one per line, such as
`.sidebar-filters`, `.advert`, or `nav`. During indexing it parses each text
field, finds every element matching one of those selectors, and removes it from
the markup so that boilerplate never becomes searchable text. The result is
better relevance (only the meaningful article body is indexed) and a smaller,
cleaner index.

An optional **post-process query** step (on by default) runs the same stripping
over the fields of returned result items, so highlighted snippets are clean too.
Selectors are validated when you save the form — a broken selector is flagged
there and simply skipped at runtime, so a typo can never break your indexing
pipeline. The module has no admin page, permissions, or configuration of its own:
everything lives inside the host index's processor settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in the
   Symfony DomCrawler dependency, and enable the module.
2. [Configuration](configuration/index.md) — add the processor to an index and
   set its CSS selectors and post-process option.

## Where it lives in the admin menu

There is no dedicated settings page. You enable and configure the processor per
index, on the **Processors** tab of each Search API index, under **Configuration
→ Search and metadata → Search API** (edit an index →
`/admin/config/search/search-api/index/<id>/processors`).

## How to use it

Enable the module, edit your Search API index, open its **Processors** tab, and
tick **HTML Element Filter**. In the processor's settings, enter the CSS
selectors for the elements you want gone (one per line), leave **post-process
query** checked if you also want result snippets cleaned, and save. Finally
re-index so existing content is re-processed. From then on, any element matching
your selectors is quietly dropped before content reaches the index. See
[Configuration](configuration/index.md) for the field-by-field walkthrough.
