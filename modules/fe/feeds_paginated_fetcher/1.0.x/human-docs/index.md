# Feeds Paginated Fetcher — manual setup guide

**Feeds Paginated Fetcher** (`feeds_paginated_fetcher`) adds a new *fetcher*
plugin to the [Feeds](https://www.drupal.org/project/feeds) module that knows how
to walk through every page of a paginated API. The standard Feeds HTTP fetcher
retrieves a single URL and hands that one response to the parser. This fetcher
replaces that single request with a loop: it fetches page one, follows the API's
pagination until there are no more pages (or a page limit is reached), merges all
the collected items into one JSON array, and delivers that combined result to the
normal Feeds parse/process pipeline — exactly as if the whole dataset had arrived
in one response.

It understands four pagination strategies — incrementing a **page number**
parameter, incrementing an **offset** parameter, following the RFC 5988 **Link**
header's `rel="next"`, or reading a **next-page URL** from a dot-notation path
inside the JSON body. It can also extract the items array from a wrapped response,
spread large imports across multiple cron runs (batch mode), retry transient
failures with backoff, and stop early when it approaches your PHP memory or
execution-time limits.

The fetcher runs on the server and follows next-page URLs supplied by the remote
server; the source URL is set by an administrator. The module validates server-supplied next-page URLs and accepts only `http://` and
`https://` schemes, and it strips carriage-return/line-feed characters from custom
headers to prevent header injection.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Feeds.

There is **no site-wide configuration page** for this module — it has no settings
form of its own. You choose and configure the fetcher on each Feed type, as
described below.

## Where it lives in the admin menu

Feeds Paginated Fetcher adds no admin page of its own. Everything happens on a
Feed type at **Structure → Feed types** (`/admin/structure/feeds`). It appears in
the **Fetcher** list when you add or edit a Feed type.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Feed types** and add a new Feed type, or edit an existing
   one.
3. In the Feed type's fetcher setting, choose the **Paginated HTTP Fetcher**.
4. Configure its options for your API — the **pagination strategy** (page number,
   offset, Link header, or JSON next link) and any parameter names it needs, the
   **items key** (a dot-notation path such as `data` or `results.items` that
   points to the items array in the response), plus optional request timeouts,
   extra query parameters, custom headers, a maximum page cap, retry count, and
   the memory/time thresholds and batch (pages-per-batch) settings.
5. Set the **parser** and **processor** on the same Feed type as usual — they
   receive the merged, multi-page result. Then create a feed of that type and run
   the import.
