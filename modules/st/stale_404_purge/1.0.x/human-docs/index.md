# Stale 404 Purge — manual setup guide

**Stale 404 Purge** (`stale_404_purge`) solves a subtle but frustrating caching
problem. When a URL is requested before the content behind it exists — before a
node is published, before a path alias is created, or before a redirect is
removed — a reverse proxy such as Varnish or a CDN can cache the `404 Not Found`
response. Once the content finally appears, the proxy keeps happily serving the
stale 404, and visitors see "page not found" for something that is actually
there. This module watches for exactly the events that make a previously-missing
URL resolvable and sends a precise, targeted purge for just those paths.

The key word is *targeted*. It never flushes the whole cache and never does broad
cache-tag invalidation — core and the Purge module's own tag queuer already
handle tags. Instead, it enqueues a purge for the specific canonical path and
alias affected by each change: a node's first publish, an unpublished-to-published
transition, a new or updated path alias, a deleted redirect, and a permanent
public file being created or having its URI change. Private files and full
redirect updates are intentionally left out of scope.

The module has no settings form of its own. Purge and Redirect are *soft*
dependencies, checked at runtime — the module has no hard requirement on either.
Without the Purge module installed and configured, the events are still detected
and logged, but nothing is actually sent upstream. To make purges happen you
install and configure Purge for your reverse proxy, then switch on the
`stale_404_purge` queuer in Purge's admin UI.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and wire it up to the Purge module.

## Where it lives in the admin menu

Stale 404 Purge has no configuration page of its own. Once the Purge module is
installed and configured, you activate this module's behavior by enabling the
**`stale_404_purge` queuer** on Purge's configuration page at **Configuration →
Development → Performance → Purge**
(`/admin/config/development/performance/purge`).

## How to use it

There is nothing to click day to day. After the queuer is enabled, the module
works quietly in the background: whenever you publish a node, add or change an
alias, delete a redirect, or replace a public file, it enqueues a targeted purge
for the affected URL through Purge's queue. Every dispatched target path set is
debug-logged, so you can confirm what was sent by watching the logs.
