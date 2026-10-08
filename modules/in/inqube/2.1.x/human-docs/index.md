# Inqube — manual setup guide

**Inqube** (`inqube`) is an Elasticsearch **Views query builder**. Its aim is to
let a Drupal View express a search against an Elasticsearch cluster: the View
holds the filters, sorts, arguments, and display, and Inqube generates the
Elasticsearch query DSL from them — so the search logic stays in configuration
that a site builder can see and change, instead of being buried in a hand-written
custom module.

It's worth being clear about what this module is. It provides **base classes** for
building Elasticsearch queries independently of any particular index — developer
plumbing that other code builds on, rather than a turnkey search feature you
switch on and use. Think of it as the foundation for a query builder, not a
finished search UI.

Two things to weigh before choosing it over **Search API**. First, Search API is
the wider *ecosystem* — facets, processors, alternative backends, and a large
body of modules that integrate with it — so a bespoke query builder trades that
ecosystem for directness. That's a reasonable trade when you need a specific
Elasticsearch capability Search API doesn't expose, and a poor one for ordinary
search. Second, **an Elasticsearch cluster reached from a View becomes a network
dependency inside a page render**: decide what a view should do when the cluster
is slow or unreachable (an unhandled failure on a search page is worse than an
empty result set), and check how queries are cached, since Views caching and
search freshness pull in opposite directions. Inqube supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. It provides base query-builder
classes for developers to build on; there is no admin settings form to fill in.

## How to use it

Inqube is developer infrastructure rather than a point-and-click feature. Once
enabled it makes its base classes available so that a custom module (or another
module built on it) can construct Elasticsearch queries from Views. Using it
therefore means writing or installing code that extends those base classes and
points at your Elasticsearch cluster — there is nothing to configure through the
admin UI on its own.
