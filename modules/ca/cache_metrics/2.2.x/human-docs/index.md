# Cache Metrics — manual setup guide

**Cache Metrics** (`cache_metrics`) logs and measures how well your site's caching
is working over time. It records cache hit and miss rates so you can see how
effective the cache actually is and spot regressions — for example, a code change
that quietly stops a page from being cached and starts costing you on every
request.

This is a developer and performance-monitoring tool, not a content or
access-control module. It adds some measurement overhead while it collects data,
so most teams turn it on during a performance-analysis phase, watch the recorded
metrics, and act on what they learn. It has no bearing on what users can see or do.

The module sits in the **Performance** package and works across Drupal 9.5, 10,
and 11.

This guide is written for a **human** working through the process. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Cache Metrics is a monitoring feature rather than a click-through admin screen — it
records cache performance in the background once enabled. There is no required
setup form; enable it, let it collect data during a period you care about, then
review the recorded hit/miss metrics to judge how effective your caching is.

## How to use it

Enable the module before a performance-analysis window, let normal traffic flow so
it can record cache hits and misses, and review the collected metrics to see
whether caching is doing its job. Because it adds measurement overhead, many teams
disable it again once they have the data they need.
