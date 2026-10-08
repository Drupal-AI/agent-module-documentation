# Search API Rabbit Hole — manual setup guide

**Search API Rabbit Hole** (`search_api_rabbit_hole`) keeps content that Rabbit
Hole has hidden from showing up in your Search API results. Rabbit Hole lets you
control what happens when someone visits an entity's page — display it, redirect,
return *Access Denied* (403), or *Page Not Found* (404). But Search API doesn't
know about those rules on its own, so a node set to "Access Denied" can still be
indexed and appear as a search result; clicking it lands the visitor on the access
denied page, which is confusing at best and a small information leak at worst.

This module closes that gap with a Search API **processor** — the "Indexing Rabbit
Hole Filter" — that prevents such content from being indexed in the first place.
By default it excludes entities using Rabbit Hole's *Access Denied* or *Page Not
Found* plugins, and you can configure exactly which Rabbit Hole behaviors should
trigger exclusion. The result is a search index that stays consistent with Rabbit
Hole's intent: hidden content simply doesn't surface in search.

The module depends on both the **Rabbit Hole** and **Search API** modules and only
does its job when both are enabled. It works on Drupal 10, 11, and 12. This is a
consistency and security-adjacent control — it aligns the search index with Rabbit
Hole's hiding — rather than an access-control mechanism of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Rabbit Hole and Search API.

## How to use it

For a worked example: set up your Article content type to use Rabbit Hole, index
Articles in a Search API index, and create an Article set to *Access Denied*.
Without this module that article still appears as a search result (though clicking
it leads to access denied); with the module configured, it is excluded from the
index entirely.

To turn it on, edit your Search API index and open its **Processors** tab
(**Configuration → Search and metadata → Search API → your index → Processors**).
Enable **Indexing Rabbit Hole Filter**. In its settings you can choose which Rabbit
Hole plugins should cause content to be excluded — it defaults to the hiding
plugins (Access Denied and Page Not Found). Save and re-index so hidden content
drops out of your results.
