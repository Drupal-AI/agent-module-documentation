# URLs queuer — manual setup guide

**URLs queuer** (`purge_queuer_url`) extends the Purge module to invalidate caches
**by URL rather than by cache tag**. Drupal's native currency is the cache tag,
which is exactly right for a reverse proxy that understands tags — but plenty of
real caches do not. A CDN or an older Varnish configuration can often only be told
to drop a specific URL. This module bridges the two: it watches traffic as pages
are served, records which URLs carried which cache tags in a **traffic registry**,
and then — when a tag is invalidated because someone edited a page — looks up the
URLs that carried that tag and queues *those* for purging.

Because it leans on Drupal 8+'s tag-based caching architecture, its accuracy is
very high. Pagers (`/news/?page=10`), RSS or JSON views (`/rss.xml`), and dynamic
blocks placed on unrelated pages all "just work" — they are purged when the
content behind them changes, without you having to map anything by hand.

There is one **important warning**: because the registry stores URLs for *all* of
your traffic, sites with thousands of content items can build an unsustainably
large registry and put real strain on the database. If you find its queries
slowing the site, the realistic options are to switch to a CDN that supports
tag-based invalidation, or to stop using this module and instead have the CDN
override your caching policy at the edge with a short TTL. The traffic-observing
middleware also sits in the request path, adding a small per-request cost.

It requires **Purge `^3.4`** and runs on Drupal `^10 || ^11`, and it ships Drush
commands for driving invalidation from a deployment. Note that it is a *queuer* —
it still needs a **purger** that can talk to your actual cache by URL or path.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Purge.

There is **no separate settings form** to detail here. The queuer is configured
from within Purge's own configuration, described in "How to use it" below.

## Where it lives in the admin menu

You manage the queuer from Purge's configuration at **Configuration → Development
→ Performance → Purge** (`/admin/config/development/performance/purge`). See the
[Purge documentation](https://www.drupal.org/project/purge) for the full pipeline.

## How to use it

1. Set up the **Purge** module, and make sure your **purger(s) support URL or path
   invalidation**.
2. Enable this module:

   ```bash
   drush en purge_queuer_url --yes
   ```
3. Give Drupal's page cache a long life so the registry can be trained, then
   rebuild caches to start clean:

   ```bash
   drush cset system.performance cache.page.max_age 31536000   # one year
   drush cache-rebuild
   ```
4. Train the traffic registry with a one-time crawl so URL-based invalidation is
   accurate from the start:

   ```bash
   wget -r -nd --delete-after -l100 --spider http://mydrupalsite/
   ```

Once trained, editing any item on your site should add several URLs to the Purge
queue — you can inspect them with `drush p-queue-browse`. From then on, ordinary
visitor traffic keeps the registry up to date automatically; no further
maintenance is needed beyond watching the registry's size on large sites.
