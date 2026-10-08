# Purge Invalidation Form — manual setup guide

**Purge Invalidation Form** (`purge_invalidation_form`) adds a simple admin form
that clears cache items *right now*. Normally the [Purge](https://www.drupal.org/project/purge)
module collects invalidations in a queue and processes them later (on cron or in the
background); this module gives you a form where you type in what you want cleared and
it goes straight to your purger(s) — Varnish, a CDN, or whatever you have configured
— synchronously, bypassing the queue entirely.

That makes it ideal for the moments when waiting isn't an option: an emergency
content fix that needs to be live on the CDN immediately, verifying that a
newly configured purger actually works, or giving ops and editors a way to clear a
specific URL without touching Drush or a terminal. You choose an invalidation
**type** — the form only offers the types your currently enabled purgers actually
support — and, for anything other than "everything", paste the items you want cleared
one per line. On submit, it invalidates each item and reports success or failure per
item, right there on the page.

Supported types depend entirely on your purger, but commonly include **URL**,
**path**, **cache tag** (for example `node:123`), **wildcard URL**, **wildcard
path**, and **everything**. If no purger is loaded, the form tells you so rather than
failing silently.

The module is deliberately small: it depends on Purge 3.6+, requires PHP 8.3, ships
one Purge processor plugin (enabled by default) that authorises the direct
invalidation, and gates the whole form behind a single restricted permission. It has
no settings page of its own — the form *is* the module.

This guide is written for a **human** using the form. If you want terse, token-cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead — they cover the `InvalidationManager` service and the processor plugin
for programmatic use.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permission.

## Where it lives in the admin menu

The form sits under Performance at **Configuration → Development → Performance →
Purge invalidation form**
(`/admin/config/development/performance/purge-invalidation-form`) — reached via a
local task tab on the Performance page. Access requires the restricted **Purge
invalidation** permission provided by this module.

## How to use it

Before the form is useful you need Purge set up with at least one **purger** enabled
(a contrib purger for your Varnish or CDN, for example) — that purger is what
determines which invalidation types appear in the form. The module's own
**Invalidation Form Processor** is enabled by default and just needs to be present.

Then:

1. Go to **Configuration → Development → Performance → Purge invalidation form**.
2. Choose a **Type** from the select list. It only shows the types your enabled
   purgers can actually handle.
3. Unless you picked **Everything**, an **Items** box appears — enter one expression
   per line. The placeholder shows examples drawn from the purger itself (a URL, a
   path, a tag like `node:123`, a wildcard, and so on).
4. Click **Purge**. Invalidation runs immediately, and you get success/failure
   feedback for each item inline. Successful invalidations are also logged to the
   module's log channel for auditing.

Because it runs synchronously in the request rather than through the queue, this is
the fastest way to force a specific item out of cache — and a handy way to debug
whether your caching and cache-tag setup is wired correctly end to end.

**For developers:** the same logic is available as the
`purge_invalidation_form.invalidation_manager` service, so you can invalidate
directly from your own code without the form or the queue — see the
[`agent/`](../agent/start.md) docs for the method signature and behavior.
