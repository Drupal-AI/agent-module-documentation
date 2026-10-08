# Entity Is Public — manual setup guide

**Entity Is Public** (`entity_is_public`) is a small **developer API** for
answering one question consistently: *is this entity publicly accessible?* Rather
than each feature re‑inventing the check, other modules call Entity Is Public's
`entity_is_public()` function (and its supporting API) to get a single, shared
answer — so sitemaps, search indexing and feeds can all agree on which content
should be treated as public.

It goes beyond simply checking `entity_access()` as an anonymous user. It also
considers conditions like: does the entity actually have a URI, and is that URI a
real front‑facing path (the front page or a non‑administrative path) rather than an
admin route? Optionally, it can require the entity to have a URL alias, and it is
aware of whether the entity will be processed by the
[Rabbit Hole](https://www.drupal.org/project/rabbit_hole) module. The result is a
more accurate notion of "publicly visible" than a bare access check.

An important distinction: Entity Is Public **reports** accessibility; it does **not
grant or restrict** it. Authoritative access control still lives with Drupal core
and `hook_entity_access()`. This module is a read‑only helper for code that needs to
*decide what to include*, not a gate that keeps anyone out. It depends on the
[Helper](https://www.drupal.org/project/helper) module and supports Drupal 10.2+, 11
and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside its Helper dependency.

There is **nothing to configure** — Entity Is Public is a service/API with no
settings form. It does its work when other code calls it.

## How to use it

Entity Is Public is meant to be called from code. A module that builds a sitemap,
indexes content for search, or generates a feed can call `entity_is_public()`
(passing the entity type, the entity, and optional options/data arrays) to decide
whether to include a given entity, and gets back `TRUE` when the entity is publicly
visible or `FALSE` otherwise. See the sibling [`agent/`](../agent/start.md) docs for
the function signature and details.
