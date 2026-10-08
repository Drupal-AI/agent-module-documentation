# Smart Cache Recommendations — manual setup guide

**Smart Cache Recommendations** (`smart_cache_recommendations`) is an AI-assisted
performance tool that analyses how well your Drupal site caches its pages and
gives you actionable, prioritised suggestions for improving it. Instead of digging
through render arrays and cache metadata by hand, you get a dashboard inside the
admin interface that points at the specific blocks, contexts, tags and max-age
settings that are holding your cacheability back.

Under the hood it looks for the usual culprits behind slow, poorly-cached pages:
**uncached blocks and components**, **missing or overused cache contexts**,
**low max-age configurations**, **over-broad cache tags** that invalidate too
much, and **expensive renders that could be deferred to a lazy builder**. It rolls
these findings into a cacheability score and impact-ranked recommendations, so you
can tackle the highest-value fixes first — which in turn helps Core Web Vitals
like LCP, FCP, TTFB and INP.

The module works on-enable — point it at your site and run a scan; there is no
mandatory settings form to fill in first. It depends only on core's **Block** and
**System** modules and supports Drupal 10 and 11. Access is gated by two
permissions: one to *view* the recommendations and one to *administer* the module.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permissions.

## How to use it

Once enabled and its permissions granted, open the **Cache Optimization
Dashboard** from the admin interface. Run a scan and the dashboard reports your
cacheability score alongside detailed diagnostics: an uncached-block report, a
cache-context analysis, max-age optimisation insights and cache-tag diagnostics,
each with an estimate of the performance improvement on offer. You can export
optimisation reports and compare scan results over time to track how your caching
improves as you apply the fixes. The two permissions — **access smart cache
recommendations** (view the dashboard and reports) and **administer smart cache
recommendations** (manage the module) — are set at **People → Permissions**;
grant the viewing permission to developers and performance staff who audit the
site.
