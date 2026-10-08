# Purge Cache Warmer — manual setup guide

**Purge Cache Warmer** (`purge_cache_warmer`) closes a gap that every cached
site has: the moment a page is purged from your CDN or reverse proxy, the very
next visitor pays the "cold cache" cost of rendering it from scratch. This
module removes that penalty. It is a **Purge purger plugin** that fires for each
URL invalidation, and for every URL that gets purged it makes a fresh HTTP
request back to your own site — so a current copy is reloaded into your caching
architecture immediately, before a real visitor ever asks for it.

Because it works from the traffic registry maintained by the **URLs queuer**
module (`purge_queuer_url`), it only warms pages that real visitors have actually
requested. It is not a whole-site crawler; it warms exactly what was purged, in
order, right after it is purged. That is what distinguishes it from cron-based
warmers like *Warmer* — the warming is tied directly to Purge's invalidation
chain rather than running on a separate schedule.

It depends on both **Purge** (`purge`) and **URLs queuer** (`purge_queuer_url`),
and the 2.x series requires **Drupal 11**. There is no settings form of its own —
you enable it and then add it to your purger list inside the Purge pipeline,
which is described below and in [Installation](installation/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and add the warmer to your Purge purger pipeline.

There is **no configuration page** for this module. It is set up entirely inside
the Purge module's own configuration, described in "How to use it" below.

## Where it lives in the admin menu

Purge Cache Warmer adds no admin page of its own. You manage it from Purge's
configuration at **Configuration → Development → Performance → Purge**
(`/admin/config/development/performance/purge`), where you add it to the list of
**purgers**.

## How to use it

The warmer only makes sense once Purge and the URLs queuer are already working,
so set those up first (see the [Purge](https://www.drupal.org/project/purge)
project for the full pipeline). Then:

1. Enable Purge and configure it, including the **URLs queuer** (`purge_queuer_url`),
   which builds the traffic registry that maps cache tags to URLs.
2. Enable this module (`drush en purge_cache_warmer --yes`).
3. Go to **Configuration → Development → Performance → Purge** and **add Cache
   Warmer to the purgers**.
4. **Reorder the purgers so Cache Warmer runs last.** It must fire after every
   other purger, once the caches are actually clear — otherwise it would warm a
   page that is about to be purged again.
5. To get accurate URL-based warming from day one, give the traffic registry a
   head start by crawling the site once:

   ```bash
   wget -r -nd --delete-after -l100 --spider https://example.com/
   ```

### Recommended processing setup

Because the module makes external calls back to your own site, the maintainers
recommend **not** using the in-request processor. Instead, process the purge
queue from an external cron via Drush:

```bash
drush pm:uninstall purge_processor_lateruntime
drush p:processor-add drush_purge_queue_work
```

Then have your external cron run `drush p:queue-work` — about once a minute is
recommended.

### Behavior worth knowing

- **TLS certificates are verified.** If you warm an `https` origin that uses a
  self-signed or internal CA certificate, the web server must trust that
  certificate.
- **Redirects are not followed.** The invalidated URL is exactly the one that
  needs warming, and the redirect response itself is what the cache should hold.
- **A 404 counts as warmed** — the caches in front of Drupal then hold a current
  copy. Server errors and 408/425/429 responses are retried.
- **Timeouts are short:** a 6-second request timeout and a 2-second connect
  timeout. Purge rejects a time hint above 10 seconds, so a page that takes
  longer than that to render will not be warmed.
