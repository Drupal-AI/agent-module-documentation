Purge is a generic, pluggable API for invalidating external caches (reverse proxies and CDNs such as Varnish, Fastly, or CloudFront) when Drupal content changes, using a queue and processors to reliably flush the right cache entries.

---

Purge itself ships no cache backend integration — it is the coordination framework that cache-invalidation modules build on. When Drupal invalidates cache tags internally, **queuers** capture those invalidations and add them to a **queue**; **processors** later drain the queue and hand invalidations to configured **purgers**, which are the plugins that actually talk to Varnish, a CDN, or another external cache. Invalidations come in typed flavours (**invalidation** plugins): tag, path, URL, wildcard path/URL, regular expression, and "everything". A **capacity tracker** rate-limits how much work purgers do per request so the site is never overwhelmed, and **diagnostic checks** surface misconfiguration (no purger installed, capacity too low, etc.) on the status report. Everything is plugin-based: it defines seven plugin types (purger, processor, queuer, queue, invalidation, diagnostic check, tags header). Configuration of enabled plugins lives in `purge.plugins` config, managed through the optional Purge UI submodule, and a comprehensive set of `p:*` Drush commands lets you add/remove plugins, inspect the queue, and trigger invalidations from the CLI. Submodules provide cron and late-runtime processors, a core cache-tags queuer, token support, and the admin UI. It targets high-performance sites that sit behind a reverse proxy or CDN and need precise, tag-based external cache clearing.

---

- Invalidate Varnish or a CDN when content is edited or deleted.
- Clear external caches by Drupal cache tag rather than flushing everything.
- Queue cache invalidations and process them reliably in the background.
- Process the purge queue on cron with the cron processor submodule.
- Process the queue on every request for low-latency setups (late runtime).
- Automatically queue every cache tag Drupal invalidates (core tags queuer).
- Purge a specific URL or path from a reverse proxy.
- Purge with wildcard paths or URLs (e.g. everything under /news/*).
- Invalidate using regular-expression cache clearing where the purger supports it.
- Flush the entire external cache ("everything" invalidation) when needed.
- Rate-limit purging via the capacity tracker to protect the origin.
- Diagnose misconfiguration (no purger, low capacity) on the status report.
- Trigger invalidations from the CLI with `drush p:invalidate`.
- Inspect queue volume and stats from Drush.
- Drain/work the queue manually with `drush p:queue-work`.
- Empty the purge queue with a Drush command.
- Add or remove purger/processor/queuer plugins via Drush or the UI.
- Configure multiple purgers and order them (move up/down).
- Provide token replacement in purger requests (purge_tokens submodule).
- Administer the whole pipeline through the Purge UI dashboard.
- Build a custom purger plugin for a new CDN or proxy.
- Add a custom diagnostic check to guard site-specific requirements.
- Emit cache-tag response headers for an edge cache via TagsHeader plugins.
- Integrate a hosting provider's cache (Fastly, Akamai, CloudFront) via a purger module.
- Support decoupled/front-end caches invalidated by tag.
