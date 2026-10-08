# Google Programmable Search — manual setup guide

**Google Programmable Search** (`google_cse`) puts Google's hosted search engine
onto your Drupal site. Instead of running your own search index (Solr, Search
API, cron indexing, field mappings), you let Google crawl your site and serve the
results. The module was formerly known as Custom Search Engine ("CSE"), which is
where the machine name `google_cse` comes from. No Google API key is required.

The trade-off is worth understanding up front. Because Google hosts the index,
there is no backend to maintain — but results only appear once Google has crawled
your site, and the on-page results are drawn by Google's own JavaScript running in
the visitor's browser. This makes the module a great fit for brochure sites,
documentation, and static content, and a poor fit if you need instant indexing of
brand-new content or fully in-Drupal control over relevance.

The module hooks into **Drupal core's Search framework**. It adds a search-page
plugin called *Google Programmable Search* and a companion block. Setup has two
halves: first you register a Programmable Search Engine on Google's site and copy
its **Search Engine ID** (called the "cx"), then you create a Drupal search page
that uses this plugin and paste that ID in. The module depends only on core's
**Search** module (`search`) and works on Drupal 10 or 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the exact configuration
keys, the plugin ids, and the drush recipes — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — register a search engine on Google,
   create the Drupal search page, and tune every option.

## Where it lives in the admin menu

The module has **no settings page of its own**. You configure it entirely through
core's Search pages screen at **Configuration → Search and metadata → Search
pages** (`/admin/config/search/pages`), where you add a search page that uses the
*Google Programmable Search* plugin. The optional block lives on the Block layout
page (`/admin/structure/block`). A permission, **View Google Programmable
Search**, controls who may run searches.

## How to use it

Once a Google search page exists, visitors search from the search box exactly as
they would with core search — but results come from Google. You can render those
results inline on your themed page, or redirect the box straight to Google's own
results page. For pages that should not use a standalone `/search/...` route,
place the self-contained **Google Programmable Search** block (a combined search
box plus results) in any region. See [Configuration](configuration/index.md) for
the full walkthrough.
