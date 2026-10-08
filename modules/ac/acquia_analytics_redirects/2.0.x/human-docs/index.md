# Acquia Analytics Redirects — manual setup guide

**Acquia Analytics Redirects** (`acquia_analytics_redirects`) fixes a specific
problem on sites hosted on **Acquia Cloud**: to improve cache hit rates, Acquia's
Varnish strips common marketing/analytics query parameters (`utm_*`, `gclid`, and
similar) from incoming requests, passing the stripped query to Drupal in an
`X-Acquia-Stripped-Query` header. When Drupal then issues a redirect, those tracking
parameters would normally be lost from the destination URL. This module re-attaches
them, so analytics attribution survives the redirect.

It does this with a single response event subscriber: when a response is a 301 or
302 redirect and that Acquia header is present, the module re-appends the stripped
query string to the redirect's target, varies the cache per query value (so Varnish
still caches correctly), and re-issues the redirect. That's the whole module.

There is **nothing to configure** — no settings form, no permissions, no admin menu
entry, no services to call. Installing and enabling it is the entire setup. This
page and the installation page are all you need.

This guide is written for a **human**. If you want a terse, token-cheap reference for
an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module. There is no configuration.

## Where it lives in the admin menu

Nowhere — the module has no admin UI and no settings. It works silently in the
background once enabled.

## How to use it

Enable it (see [Installation](installation/index.md)) on a site fronted by Acquia
Cloud Varnish, and it takes effect immediately. No configuration, no maintenance.

> **Built for the Acquia Varnish tier.** The module only does anything when the
> `X-Acquia-Stripped-Query` header is present, and that header is produced by Acquia
> Cloud's Varnish. On a site that is not fronted by that Varnish tier the header is
> normally absent, so the module is a no-op — it is designed for, and only useful on,
> Acquia Cloud. Also note that core's Internal Page Cache module must be
> disabled/uninstalled for the module to take effect.
