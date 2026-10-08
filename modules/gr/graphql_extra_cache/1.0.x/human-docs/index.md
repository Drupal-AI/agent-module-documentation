# GraphQL Extra Cache — manual setup guide

**GraphQL Extra Cache** (`graphql_extra_cache`) adds an extra layer of caching
to GraphQL responses, on top of what the GraphQL module already does. Its own
tagline is "Cache all the things." It is built to work with the **GraphQL** and
**GraphQL Core Schema** modules, and once enabled it starts serving repeated
queries from cache with no configuration.

GraphQL is notoriously hard to cache from the outside: a request is a POST whose
body describes an arbitrary selection, so a proxy or page cache can't tell that
two different requests overlap in what they return. The GraphQL module has its
own caching layer, but it runs relatively late in the request lifecycle. This
module inserts a cache layer *earlier* — it can skip parsing and validating the
whole POST body when it recognizes a query it has already answered, which is
where the performance win comes from. Invalidation still rides on Drupal's cache
tags, so when a node is saved every cached response containing that node is
cleared automatically.

There is nothing to click: once the module is enabled it alters the GraphQL
Core Schema route and begins caching. If you run your own custom schema rather
than `graphql_core_schema`, you can still use it, but you'll need to write your
own `RouteSubscriber` to match and alter your route and add the cache layer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside GraphQL and GraphQL Core Schema.

There is **no configuration page** for this module — it works automatically once
enabled.

## A word on correctness before you cache

Any response cache carries one serious risk: a response cached without the
contexts it varies by can be served to the wrong person. A GraphQL query that
resolves fields the *current user* is allowed to see produces a user-specific
answer, and unlike a page render — where Drupal collects cache contexts as the
render tree is built — a GraphQL resolver has to propagate those contexts
deliberately. Before you rely on this in production, test it: run a query that
returns unpublished content as an **editor**, then the same query as an
**anonymous** visitor, and confirm the anonymous request never receives the
editor's cached response. Then reverse the order and check again.
