# Configuration

Custom Purge is configured in two layers: the **caching instances** you define in
YAML (which caches exist and how to reach them), and the **day-to-day purging**
you do from the admin form and Drush.

> **Important:** this module does **not** provide a settings form for its main
> configuration (`custom_purge.settings`). You edit the configuration YAML by hand
> and import it with `drush config:import`. Keep any secrets (such as a Cloudflare
> API key) out of committed configuration where possible.

## Define your caching instances (YAML)

The module's configuration is a `custom_purge.settings` object built around
**profiles** — for example a `production` profile — each of which lists the
**cache instances** to purge and the **domains** those instances serve. Edit the
config, then import it:

```bash
drush config:import
```

A caching instance describes one cache target. The most useful keys are:

- **`cache_type`** — which built-in plugin to use: `drupal_page_cache`, `varnish`,
  or `cloudflare`.
- **`cache_name`** — a name you choose to refer to this instance (domains reference
  it by this name).
- **`allow_url_purge`** — whether single-URL purges are allowed against this cache.
- **`allow_purge_everything`** — whether "purge everything" is allowed against it.
- **`delay_complete_purge`** — how long (in seconds) to wait before a full purge
  actually runs. `0` means run immediately; a larger value (e.g. `1800` or `3600`)
  delays the complete purge, which the queue honours by re-queuing the item until
  the delay is reached.

Each plugin then takes its own connection details, for example:

- **Drupal page cache** — `cache_name` such as `internal_page_cache`, plus
  `cid_extensions` listing the cache-id suffixes to clear (`':'`, `':html'`,
  `':json'`, `':xml'`, `':xhtml'`).
- **Varnish** — `ip`, `port`, `verifyhost`/`verifypeer` (TLS verification), and
  `single` / `everything` blocks giving the HTTP method (e.g. `DELETE` for a single
  URL, `BAN` for everything), headers, and a ban URL.
- **Cloudflare** — `email`, `zone_id`, and `apikey` (or `use_cf_settings` to reuse
  another source of Cloudflare settings).

Finally, **domains** map your site's hostnames to the cache instances that serve
them, via `assigned_cache_instances` (a list of `cache_name` values). One domain
is typically marked `is_default: true`.

The per-profile keys `max_url_per_request`, `flood_interval`, and `flood_limit`
cap how many URLs are purged per request and rate-limit purge activity.

## Purge specific URLs (admin form)

For everyday work, Custom Purge provides a **purge URLs form** in the admin UI
(guarded by the module's own permission — grant it only to trusted users). Enter
the URLs you want to clear and submit; the module purges them from the caching
instances that allow URL purges.

## Purge everything (Drush + queue)

"Purge everything" runs through Drupal's queue so it can be paced by cron rather
than hammering your caches at once. The module provides Drush commands to enqueue
these purges. To process the queues on a schedule, run:

```bash
drush queue:run custom_purge_urls --items-limit=100
drush queue:run custom_purge_everything --items-limit=100
```

Each queue item takes roughly one second to process. If you see more items
processed than expected, that's by design: an item whose `delay_complete_purge`
hasn't elapsed re-queues itself (adding about a second of wait) and only performs
the actual purge request once its delay is reached.

Make sure a **regular cron run** is in place, or schedule the two `queue:run`
commands above, so queued purges actually execute.
