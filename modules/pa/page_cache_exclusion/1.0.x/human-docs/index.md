# Page Cache Exclusion — manual setup guide

**Page Cache Exclusion** (`page_cache_exclusion`) lets you stop Drupal's
anonymous Internal Page Cache from storing specific pages — without turning off
page cache across the whole site. You can exclude pages three ways: by **path**
(individual URLs or wildcard patterns), by **query parameters** (don't cache a
path whenever the request carries any `?…` parameters), and for **4xx
responses** (never cache client-error pages like 403/404). Everything else keeps
being cached as normal, so you keep the performance win while keeping a handful
of volatile URLs fresh.

It works by hooking into the point where a rendered response would be written to
the page cache, and skipping that write when one of your rules matches. Because
it only skips the *write*, a page that is already cached keeps serving from cache
until it expires — so after adding a rule you may want to clear caches to flush
existing entries. It also only affects the anonymous page cache; Dynamic Page
Cache and render caching are untouched, and logged-in traffic already bypasses
page cache anyway.

Paths use Drupal's standard matcher, so `*` wildcards and `<front>` work, and
matching is done against both the internal system path and the URL alias.
Everything is set on a single admin form and stored in configuration, so the
rules export and deploy with the rest of your site config.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the three exclusion settings and
   how path matching works.

## Where it lives in the admin menu

The settings form sits under **Configuration → Development → Performance → Page
Cache Exclusion**
(`/admin/config/development/performance/page_cache_exclusion`) and needs the
**Administer site configuration** permission.
