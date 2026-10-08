# Search Exclusion by Node id — manual setup guide

**Search Exclusion by Node id** (`search_exclude_nid`) hides specific nodes from
Drupal core's search results by their node ID — without unpublishing them or
changing who can see them. The nodes stay fully viewable by their direct URL;
they just stop appearing in the standard search listing.

It is deliberately tiny. You get one admin form with a single box where you type
a comma-separated list of node IDs. On save, each ID is validated against your
existing nodes, de-duplicated, and stored. From then on, whenever core Search
runs its node search, the module quietly adds a "not in this list" condition to
the query so those nodes are filtered out.

A couple of things worth knowing: it only touches **core Search's** node search.
It does not affect Search API, Views, or node access, and it does not hide the
nodes anywhere else. The exclusion list is stored in Drupal's **State** (not
configuration), so it is per-environment and is not exported with your site
configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Once enabled, its settings form sits at **Configuration → Search and metadata →
Search Exclusion by Node id** (`/admin/config/search/search_exclude_nid`). You
need the **Administer search exclude nid** permission to reach it.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). Core's
   **Search** module must be enabled and configured — this filters the standard
   node search.
2. Go to **Configuration → Search and metadata → Search Exclusion by Node id**.
3. In the single text box, type the node IDs you want to hide as a
   comma-separated list, for example `1,4,8,23`.
4. Save. Each value is checked against your existing nodes — invalid or
   duplicate IDs are dropped with a warning, and the clean list is stored.

To bring a node back into search, simply remove its ID from the list and save
again. Because the exclusion is applied globally to core node search, the change
affects search results for all users immediately.

Typical uses: keeping a landing page reachable by URL but out of the search
results, pulling an outdated article from search without unpublishing it, or
suppressing utility pages (thank-you pages, redirects) and near-duplicates.
