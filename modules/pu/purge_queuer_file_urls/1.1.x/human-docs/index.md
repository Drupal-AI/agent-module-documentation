# File URLs Queuer — manual setup guide

**File URLs Queuer** (`purge_queuer_file_urls`) plugs into the Purge framework to
handle a case the standard queuers miss: **cached files**. When a fieldable entity
is updated, this module queues the URLs of files referenced from that entity's
file fields for cache invalidation — and it also queues the **image styles** and
**image derivatives** of any files it discovers. The result is that your CDN or
reverse proxy stops serving stale copies of files and thumbnails after content
changes.

It is deliberately flexible about *how* those files get invalidated. You can queue
**absolute URLs**, **relative URLs (file paths)**, or **regex/wildcard patterns**;
filter by file scheme (public, private, and so on); and manually configure base
URLs. Under the hood it exposes an **ExpressionStrategy plugin system**, so
developers can customize exactly how invalidation expressions are generated for
files, styles, and derivatives.

It depends on core **File** (`file`) and the **Purge** module (`purge`), and runs
on Drupal `^9 || ^10 || ^11`. Like all Purge queuers, it queues invalidations but
does not send them itself — you need a **purger** that can handle the invalidation
type you choose (for example a `relativeurl` or `absoluteurl` purger).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Purge.

There is **no separate settings form**. The queuers this module provides are
configured from within Purge's own configuration, described in "How to use it"
below.

## Where it lives in the admin menu

You manage everything from Purge's configuration at **Configuration → Development
→ Performance → Purge** (`/admin/config/development/performance/purge`), where the
module's queuers appear alongside the others. See the
[Purge documentation](https://www.drupal.org/project/purge) for the overall
pipeline.

## How to use it

1. Set up the **Purge** module and make sure you have a **purger** that supports
   the kind of file invalidation you want (relative URL, absolute URL, etc.).
2. Go to **Configuration → Development → Performance → Purge** and enable the
   **Files Queuer** (and the **Image Styles Queuer**, if you want style
   derivatives invalidated too).
3. Use the **configure** drop-down on your Files Queuer instance to open its
   options. There you choose:
   - the **invalidation method** for files, image styles, and derivatives
     (absolute URL, relative URL/path, or regex/wildcard);
   - which **file schemes** to act on (public, private, etc.);
   - any manually configured **base URLs**.
4. Save. From now on, editing an entity queues invalidations for the files it
   references.

Out of the box, a file's **relative URL** is used as the invalidation expression,
so pair it with a matching (`relativeurl`) purger. The module adds several file-
oriented invalidation types beyond those in base Purge.

### For developers

Invalidation-expression generation is a plugin system. You can override an
existing strategy with `hook_expression_strategy_info_alter()`, or write your own
plugin by extending `ExpressionStrategyBase` and implementing one of the strategy
interfaces (`FileExpressionStrategyInterface`,
`DerivativeExpressionStrategyInterface`, `StyleExpressionStrategyInterface`). Most
other functionality is exposed as overridable services.
