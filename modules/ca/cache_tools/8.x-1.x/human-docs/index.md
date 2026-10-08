# Cache Tools — manual setup guide

**Cache Tools** (`cache_tools`) is a set of caching-related utilities for developers.
It provides helpers for working with Drupal's cache system — things like
invalidation, cache tags, inspection, and programmatic cache operations — aimed at
people building cache-aware features rather than at site administrators.

This is a developer toolkit, in the **Cache** package. The operations it helps with
affect performance and content freshness, not access: it has no access-control role.
You install it because your code (or another module) wants to use its helpers when
handling caches.

The module supports a wide range of core versions — Drupal 8.8, 9, 10, and 11.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including what the utilities offer —
read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — Cache Tools adds no admin pages, routes, permissions, or settings form. It
is a developer utility, used from code.

## How to use it

Enable the module, then use its cache utilities from your own code when you need to
invalidate caches, work with cache tags, inspect cache state, or perform other
programmatic cache operations. See the [`agent/`](../agent/start.md) docs for the
developer-facing details.
