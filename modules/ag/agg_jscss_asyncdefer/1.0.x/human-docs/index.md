# Aggregation JS CSS async defer — manual setup guide

**Aggregation JS CSS async defer** (`agg_jscss_asyncdefer`) adds the `async` and
`defer` attributes to Drupal's asset libraries and produces aggregate files that
carry those attributes. The goal is front-end performance: a plain synchronous
`<script>` blocks the browser from parsing the rest of the page while it downloads
and runs, which is one of the biggest self-inflicted delays on a typical page.
`defer` fixes that by downloading in parallel and running after parsing, in order;
`async` downloads in parallel and runs whenever it arrives, out of order.

Drupal core already lets *you* set these attributes per library in a
`libraries.yml` file — but only for libraries you own, and most of a site's script
weight comes from core and contrib libraries whose declarations are not yours to
edit. This module turns the attribute into a site-level setting so you can apply
it more broadly, and it handles the tricky interaction with aggregation (where
several libraries are bundled into one file and so cannot simply share a single
attribute).

**Treat this as a change to test, not one to switch on and walk away from.** Two
things make it risky if applied bluntly:

1. **Order and timing.** `async` reorders script execution, so a script that
   depends on another that has not run yet fails *intermittently* — the worst kind
   of failure, because it depends on network timing and often will not reproduce
   on a fast local connection. `defer` preserves order and is the safe default;
   reach for `async` only for genuinely independent scripts such as analytics.
2. **Drupal's own JavaScript has dependencies** — `drupalSettings`, `once`, and
   behaviours attaching on `DOMContentLoaded`. Applying an attribute broadly to
   core and contrib libraries is exactly where intermittent breakage comes from.

The sound approach: **measure the gain, apply narrowly, and test on a throttled
connection** rather than a fast local one.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once enabled, the module lets you apply `async`/`defer` at the site level rather
than editing individual `libraries.yml` files. A practical workflow:

1. Establish a baseline — run a performance audit (for example Lighthouse) and
   note the render-blocking scripts.
2. Prefer **`defer`** as your default, because it preserves execution order and
   is far less likely to break dependent scripts.
3. Use **`async`** only for scripts that are genuinely independent of everything
   else on the page, such as third-party analytics.
4. Apply changes narrowly, then re-test — ideally on a throttled/slow connection,
   which is where ordering bugs actually surface — before rolling out to
   production.
