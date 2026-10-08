Cache Flush Time shows a status message reporting the date and time each time the Drupal cache is rebuilt.

---

Cache Flush Time is a minimal developer/operations convenience module. It implements a single core hook, `hook_cache_flush()`, so that whenever Drupal rebuilds its caches — via the UI "Clear all caches" button, `drush cache:rebuild`, or any programmatic cache flush — a Drupal status message ("Cache flushed at <datetime>") is added for the acting session. The timestamp comes from the server clock (`time()`) formatted with the site's "short" date format via the `date.formatter` service. There is no configuration, no routes, no permissions, no blocks, and no stored state; the module simply annotates the flush event with the time it occurred so developers and site operators get immediate confirmation that a rebuild ran and when.

---

- Confirm at a glance that a cache rebuild actually completed after clicking "Clear all caches" at `/admin/config/development/performance`.
- See the exact time a flush happened while debugging a caching issue.
- Verify that a `drush cache:rebuild` run triggered a real flush during a deploy.
- Give newer team members a visible signal that their cache clear took effect.
- Correlate a stale-content report with when caches were last cleared.
- Spot repeated or accidental double cache clears during a working session.
- Add lightweight operational feedback on a local or staging development site.
- Timestamp cache rebuilds while profiling front-end performance changes.
- Confirm a cache flush ran as part of a config import workflow.
- Provide a quick sanity check after running an update hook that clears caches.
- Help QA note the moment caches were reset while reproducing a bug.
- Give a visual cue in the admin UI when clearing caches during theme development.
- Track cache clears while testing cache-tag or cache-context invalidation logic.
- Reassure operators during incident response that a manual flush was applied.
- Teach the Drupal cache-flush lifecycle by making the flush event visible.
- Confirm caches were cleared before demonstrating a change to a client.
- Add a low-risk, dependency-free utility module to a developer toolkit.
- Notice when an automated task (cron, deploy hook) rebuilt caches, if it runs in a session that shows messages.
- Sanity-check cache behavior on multisite installs where flushes are frequent.
- Provide immediate feedback in local Lando/DDEV environments after `drush cr`.
