Purge Cron Processor drains the Purge queue on every cron run, the recommended way to process external cache invalidations for most sites.

---

This tiny submodule of Purge provides a single **processor** plugin (`CronProcessor`) that hooks into Drupal's cron. On each cron run it claims a chunk of queued invalidations (limited by the capacity tracker) and hands them to the configured purgers, which flush the external cache. It is the default, low-maintenance way to keep an external cache (Varnish, CDN) in sync with content changes without adding request-time latency. Processing volume per run is bounded by purger-declared capacity, so a large backlog drains over several cron runs. It has no configuration, schema, or permissions of its own — enabling the module is enough. Pair it with a queuer (typically Core tags queuer) and a purger for your cache. On sites where cron runs frequently this is sufficient; sites needing near-instant invalidation add the Late runtime processor instead of, or alongside, this one.

---

- Process the purge queue automatically on cron.
- Keep a CDN/reverse proxy in sync without manual purging.
- Drain queued cache-tag invalidations in the background.
- Avoid adding invalidation latency to visitor requests.
- Use the recommended default processor for most setups.
- Let a large invalidation backlog drain across cron runs.
- Respect purger capacity limits during processing.
- Run alongside the core tags queuer for tag-based clearing.
- Combine with a Varnish or Fastly purger module.
- Trigger processing via `drush cron`.
- Set up hands-off external cache invalidation.
- Process invalidations without enabling the late-runtime processor.
- Keep request performance unaffected by cache clearing.
- Handle scheduled content publishing cache clears on cron.
- Provide a baseline processor for a fresh Purge install.
- Drain the queue on cron-driven CI/deploy hooks.
