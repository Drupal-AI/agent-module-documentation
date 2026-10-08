# Domain Access Search API — manual setup guide

**Domain Access Search API** (`domain_access_search_api`) teaches the
[Search API](https://www.drupal.org/project/search_api) framework the "current
domain" trick that [Domain Access](https://www.drupal.org/project/domain) already
does for ordinary database queries. On a multi-domain (affiliate) site, Domain
Access ships a *Current domain* Views filter — but that filter only works against
Drupal's SQL entity storage, not against a Search API index (Solr, database
index, etc.). This module re-implements the same idea for Search API-backed views,
so a search results page can automatically show only the content published to the
site the visitor is browsing.

It adds two things. First, a **Views filter** called *Search API: Current domain*
that you drop into any Search API index-based view; when its value is set to *Yes*
it restricts the view to items whose `field_domain_access` matches the active
domain. Second, an optional **index processor** ("Apply domain access all
affiliates to allowed domains property") that makes content flagged for *all
affiliates* match on every domain, so a shared announcement surfaces in each
site's search without being duplicated.

There is no settings page to fill in. All the work happens where you already build
search: on the Search API index (adding the required fields and, optionally, the
processor) and inside the view (adding the filter). Because of that, treat this as
a site-building tool rather than a security layer — the filter only narrows results
when you actually add it to a view and turn it on. It does **not** enforce Domain
Access the way node access grants do; a view without the filter returns everything
in the index.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Domain Access and Search API.
2. [Configuration](configuration/index.md) — index the required fields, enable the
   optional all-affiliates processor, and add the filter to a view.

## How to use it

There is no admin menu item — the module wires itself into the Search API and
Views UIs. In short: add `field_domain_access` (and, for the all-affiliates
behavior, `field_domain_all_affiliates`) to your Search API index, then add the
**Domain → Search API: Current domain** filter to your view and set it to *Yes*.
The full step-by-step is on the [Configuration](configuration/index.md) page.
