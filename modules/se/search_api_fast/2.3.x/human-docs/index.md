# Search API Fast — manual setup guide

**Search API Fast** (`search_api_fast`) makes a full Search API reindex dramatically
quicker by running several indexing workers **at the same time**. Search API
normally indexes in batches, one item after another, on cron or through Drush. On a
large site — the module's own guidance mentions sites with more than 10,000 nodes —
that turns a reindex into an overnight job. Search API Fast spawns parallel Drush
workers across multiple CPU cores so the work is done in a fraction of the time.

The reason this works is that the bottleneck is usually **not** the search backend.
It's Drupal bootstrapping and rendering each item, which parallelises well. By
distributing items across several worker processes, the module keeps more of your
CPU busy and shortens the window you need after a schema change, a processor change,
a content migration, or a fresh deploy. It depends on **Search API** (`search_api
^1.0`) and, crucially, on **Drush and a Unix/Linux-based system** — it is a
command-line tool, not something you trigger from a browser.

There is one operational judgement to make, and it matters: how many workers to
run. Workers compete for database connections, PHP processes, and search-backend
throughput, so the right count is the one your infrastructure can actually support.
Set it too high and you can turn a slow reindex into an outage — the database
connection limit is often the first thing to hit. **Test on a copy of production
before running it against the real thing.** Worker count and a few other options are
tunable; see [Configuration](configuration/index.md).

This guide is written for a **human** working through the admin UI and command
line. If you are an AI agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the optional performance settings
   (worker count, batch size, respawn threshold, Drush path).

## Where it lives in the admin menu

The optional settings form sits at **Configuration → Search and metadata → Search
API Fast** (`/admin/config/search/search-api-fast`), gated by the **Administer site
configuration** permission. The same settings can be set in `settings.php`.

## How to use it

The module is driven from **Drush**, run from your webroot:

```bash
# Index a Search API index using parallel workers
drush sapi-fast [index-name]

# Mark all items for reindexing first, then index
drush sapi-fast [index-name] reindex

# Clear the index, then reindex from scratch
drush sapi-fast [index-name] clear
```

While it runs you can watch the workers spawn with `top` or
`ps -ef | grep drush`.
