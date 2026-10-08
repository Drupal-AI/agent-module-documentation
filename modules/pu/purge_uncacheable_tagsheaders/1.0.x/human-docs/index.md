# Purge Uncacheable Tags Headers — manual setup guide

**Purge Uncacheable Tags Headers** (`purge_uncacheable_tagsheaders`) fills a small
but real gap in how Purge emits its cache-tags response headers. By default, Purge
only attaches those headers to responses Drupal considers **cacheable**. This
module extends that behavior so the same tags headers are also emitted on
responses Drupal marks **uncacheable** (`no-cache`) — so an upstream shared cache
that makes (or overrides) its own caching decision can still see those tags and
later invalidate them.

The classic use cases are **POST GraphQL requests**, which Drupal never treats as
cacheable, and setups where the real caching decision happens at a CDN or reverse
proxy rather than in Drupal. In both cases you want the cache-tag metadata to reach
the edge even though Drupal itself would not cache the response.

It is completely **configuration-free**: there is no settings form, no routes, no
permissions, and no admin UI. You install Purge, configure a tags-header plugin
(for example the Cache-Tags header for your proxy), enable this module, and the
headers begin appearing on `no-cache` responses. It reuses your existing Purge
tags-header plugin configuration — each plugin still decides its own header name
and value formatting.

It depends on the **Purge** module (`purge >= 8.x-3.3`) and runs on Drupal `^9.5
|| ^10 || ^11`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Purge.

There is **no configuration page** — the module has no settings at all. Behavior
is automatic once a Purge tags-header plugin is configured, described in "How to
use it" below.

## Where it lives in the admin menu

The module adds nothing to the admin menu. You configure the underlying tags-header
plugin from Purge's own configuration at **Configuration → Development →
Performance → Purge** (`/admin/config/development/performance/purge`).

## How to use it

1. Set up the **Purge** module and configure a **tags-header plugin** — for
   example, the Cache-Tags header your Varnish/Fastly/CDN setup expects.
2. Enable this module. That is the entire setup — there is nothing to configure.
3. From then on, the tags headers computed by your Purge plugins are also written
   onto `no-cache` responses on the main request (sub-requests are left alone), so
   your edge can invalidate dynamic and personalised endpoints by tag.

> **Security note:** this exposes cache-tag headers on **more** responses than
> core does. If your tags-header plugin's output is considered sensitive, restrict
> it at the edge exactly as you would for cacheable responses. The module makes no
> external calls, handles no request data, and adds no mutating endpoint — it only
> attaches headers that Purge plugins already compute.
