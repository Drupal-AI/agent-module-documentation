# Internal Page Cache Vary — manual setup guide

**Internal Page Cache Vary** (`page_cache_vary`) is a low‑level, developer‑oriented
module that makes Drupal's internal page cache emit correct HTTP **`Vary`**
headers, so a CDN or reverse proxy in front of your site can cache page variants
correctly.

Here is the problem it solves. Drupal's internal page cache already varies its
responses by "cache contexts" — but it does not surface those variations as
`Vary` headers. That means a CDN or reverse proxy sitting in front of Drupal has
no way to know that a page differs by, say, a device type or a country header, and
can end up caching and serving the wrong variant. This module replaces the core
page‑cache middleware with a variant that computes the appropriate `Vary` header
for each URL, derived from the cache contexts that opt in, and stores that
metadata so the same `Vary` is returned consistently for a URL (as the HTTP spec
requires).

To make a cache context contribute a header, a developer implements the module's
`VaryCacheContextInterface` on that context's service, declaring which request
header(s) it varies on. There is no admin UI, no routes, no permissions, and no
configuration — installation is essentially "enable and profit," and the developer
work is done in code.

Because it swaps a core middleware service, exercise a little care: verify the
behavior with your specific CDN, and watch for interactions with any other module
that also alters the page cache. You can always roll back by simply disabling the
module, which restores the stock core page cache.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and ensure core Page
   Cache is enabled.

There is **no configuration page** for this module. Enabling it activates the
Vary‑aware page cache; contributing a header from a cache context is a coding task
(implement `VaryCacheContextInterface`), summarized below.

## How to use it (for developers)

1. Install and enable the module (see [Installation](installation/index.md)) — the
   Vary‑aware middleware takes over automatically.
2. In code, implement `\Drupal\page_cache_vary\VaryCacheContextInterface` on the
   cache‑context service you want to expose, returning the request header(s) it
   varies on from `getVaryHeaders()`.
3. Clear caches, then confirm the emitted `Vary` header on cached responses and
   verify your CDN caches the variants as expected.
