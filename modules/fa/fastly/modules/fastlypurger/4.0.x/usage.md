Fastly Purger connects the Fastly module to the contributed Purge module, providing a Fastly purger plugin so Purge's queue/processor pipeline invalidates Fastly's cache (by tag, URL, or everything).

---

This submodule (enable it separately; it depends on `fastly` and `purge`) registers a Purge **purger plugin** with id `fastly` (label "Fastly") that supports the invalidation types `tag`, `url`, and `everything` and is single-instance (`multi_instance = FALSE`). Its `FastlyPurger` routes each type to the matching Fastly API call via the shared `fastly.api` service — tags are hashed through `CacheTagsHash` and purged as Surrogate Keys, URLs are purged directly, and "everything" purges all. It also ships a Purge **diagnostic check** `fastly_creds` (`CredentialCheck`) that warns in Purge's status report when the configured Fastly credentials are missing or invalid, and a service provider (`FastlypurgerServiceProvider`) that removes the `cache_tags_invalidator` tag from the parent module's `fastly.cache_tags.invalidator` service so that, once Purge is in charge, cache-tag invalidation flows through Purge's queue instead of being purged immediately by Fastly's own invalidator. It defines no configuration of its own — Fastly credentials/purge settings come from the parent Fastly module's forms, and the purger is added and ordered through the Purge module's UI or its Drush commands. Actual purging requires valid Fastly credentials and network access.

---

- Route Drupal cache-tag invalidations to Fastly through the Purge module's queue and processors.
- Add "Fastly" as a purger in Purge's configuration (`/admin/config/development/performance/purge`).
- Queue purges instead of purging immediately, decoupling content saves from CDN calls.
- Invalidate Fastly by cache tag (Surrogate Key) via the Purge pipeline.
- Invalidate a specific URL on Fastly through Purge.
- Invalidate everything on Fastly via a Purge "everything" invalidation.
- Process the Purge queue on cron so Fastly purges happen in the background.
- Get a Purge status-report warning when Fastly credentials are missing/invalid (`fastly_creds`).
- Use Purge's diagnostics to block processing until Fastly credentials are valid.
- Combine Fastly with other Purge queuers (e.g. core cache tags queuer).
- Let Purge's rate-limited processors throttle how fast Fastly is purged.
- Hand cache-tag invalidation to Purge instead of Fastly's direct invalidator.
- Add the Fastly purger from the CLI with Purge's `p:purger-add fastly`.
- Order the Fastly purger relative to other purgers in a multi-CDN setup.
- Drive Fastly purging from Purge's queue processor cron run.
- Integrate Fastly into an existing Purge-based invalidation architecture.
- Test that credentials work before enabling processing, via the diagnostic check.
- Keep a single Fastly purger instance (the plugin is single-instance).
- Reuse the parent Fastly module's API settings for all Purge-driven purges.
- Support tag, url, and everything invalidation types from one purger.
