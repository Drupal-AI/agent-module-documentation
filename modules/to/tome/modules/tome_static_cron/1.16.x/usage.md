<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Tome Static Cron builds the static site incrementally on cron: instead of running `drush tome:static` by hand, it queues uncached paths on each cron run and works through them with a queue worker until the Tome Static cache is full.

---

For sites that keep a persistent Drupal running (not the pure flat-file workflow), Tome Static Cron generates static HTML in the background. On each `hook_cron()` it checks its configured Base URL (`tome_static_cron.settings:base_url`) — if empty it does nothing — then, if the `tome_static_cron` queue is empty, it prepares the static directory, collects all uncached paths via the `tome_static.generator` service, and enqueues them (plus a final `process_invoke_paths` marker item) into the `tome_static_cron` queue. The `TomeStaticQueueWorker` queue worker then renders each queued path on subsequent cron runs, tracking invoke/old paths in state so newly-discovered assets get queued too. Because it relies on Tome Static's cache, only paths that are not already cached are (re)generated, giving incremental builds. You must set the Base URL at `/admin/config/services/tome_static_cron/settings` (gated by the `use tome static` permission) so absolute URLs render correctly in the cron context. It adds no Drush command of its own — the Base URL config plus core cron are the whole interface.

---

- Generate a static site automatically in the background instead of running `drush tome:static` manually.
- Keep a static production copy fresh on a schedule via Drupal cron.
- Incrementally regenerate only uncached paths, spreading work across cron runs.
- Run large static builds a chunk at a time so a single request never times out.
- Configure the Base URL used for cron-context static generation.
- Serve a persistent Drupal editorial backend while cron ships static HTML to production.
- Rebuild affected pages after content edits on the next cron once their cache is cleared.
- Avoid manually kicking off builds on a busy editorial site.
- Pair with tome_static_super_cache so cron builds stay cached longer.
- Queue newly discovered assets (image derivatives, etc.) automatically as paths are processed.
- Disable cron generation instantly by clearing the Base URL setting.
- Throttle static generation to cron cadence rather than an all-at-once export.
- Use with a real cron runner (system cron, `drush cron`) for hands-off publishing.
- Keep the static output directory prepared and cleaned up by the cron process.
- Ensure only one build cycle runs at a time (skips if the queue still has items).
- Integrate static generation into an existing cron-based ops pipeline.
- Generate static HTML for a site where editors expect changes to appear without manual steps.
- Set a canonical production domain for generated links via Base URL.
- Track build progress through the `tome_static_cron` queue length.
- Combine with the Tome Static admin UI/CLI for occasional full rebuilds plus cron top-ups.
