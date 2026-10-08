Late runtime processor drains the Purge queue at the end of every web request, giving near-instant external cache invalidation on setups where waiting for cron is too slow.

---

This Purge submodule registers a **processor** plugin (`LateRuntimeProcessor`) plus an event subscriber (`EventSubscriber\LateRuntimeProcessor`) that fires late in Drupal's request lifecycle, after the response is prepared. On each request it claims and processes a capacity-limited chunk of the purge queue, so invalidations are flushed to the external cache within seconds of being queued rather than on the next cron run. Because it runs on every request it adds a small amount of work to page generation, so the module description explicitly recommends it only for "high latency configurations" — situations where cron-based processing is not fast enough. It is typically combined with (not a replacement for) the cron processor. It has no configuration, schema, or permissions; enabling it is sufficient. Capacity limits still apply, so a big backlog is spread across many requests to avoid overloading purgers.

---

- Flush external caches within seconds of a content change.
- Process the purge queue on every web request.
- Achieve near-instant CDN/reverse-proxy invalidation.
- Avoid waiting for the next cron run to clear caches.
- Use on high-latency setups where cron is too slow.
- Complement the cron processor for faster draining.
- Keep the queue short by draining continuously.
- Respect purger capacity limits per request.
- Process invalidations after the response is built (late in the request).
- Give editors fast feedback that changes are live.
- Support time-sensitive publishing workflows.
- Drain backlog gradually across many requests.
- Run without any configuration (enable-and-go).
- Pair with the core tags queuer for tag invalidation.
- Speed up cache clearing on low-traffic sites without frequent cron.
- Reduce stale-content windows on a fronted site.
