Cron Last Run Manipulate provides an admin form that rewinds the recorded last-cron-run timestamp so cron-dependent behaviour can be triggered on demand during development and testing.

---

The module adds a single admin form at `/admin/manipulate/cron/last-run-time` (permission `administer site configuration`) that overwrites Drupal's `system.cron_last` state value. You pick an interval from a select list (1 minute up to 1 hour, in 5-minute steps) or choose a custom number of seconds, and the module sets `system.cron_last` to "now minus that interval". This makes the site behave as if cron last ran that long ago, which — in combination with the required Automated Cron module — lets the automatic cron run fire on the next page request once the elapsed time exceeds the configured interval. The chosen interval is validated against `automated_cron.settings.interval` (the maximum cron interval). It ships no permissions of its own, no config schema, no plugins, no Drush commands, and stores only two small State values (`system.cron_last` and its own `cron_last_run_manipulate.time` / `cron_last_run_manipulate.custom_time`).

---

- Force Drupal's automatic cron to run on the next request without waiting for the real interval to elapse.
- Simulate a site whose cron last ran an hour ago to test time-sensitive cron logic.
- Rewind `system.cron_last` while developing a module's `hook_cron()` implementation.
- Reset the cron timestamp after importing a database where cron_last is stale or in the future.
- Trigger queue processing that only runs on cron, during local development.
- Test scheduled-content publishing/unpublishing that depends on cron cadence.
- Verify cache-expiry or purge jobs wired into cron without waiting real time.
- Debug why a cron-dependent feature is not firing by nudging the last-run time back.
- Repeatedly re-arm automatic cron between manual test iterations.
- Set the last run time to just under the Automated Cron interval to test near-boundary behaviour.
- Set a custom seconds value for precise, reproducible cron-timing tests.
- Confirm Automated Cron's interval setting behaves as expected against a known last-run offset.
- Demonstrate cron-triggered functionality in a QA or staging walkthrough on demand.
- Avoid editing the `key_value` / state table by hand to change `system.cron_last`.
- Re-trigger Search API, Scheduler, or similar cron-driven modules during development.
- Provide a quick admin-only toggle for testers who should not use Drush.
- Check that a newly added cron hook runs at all by moving the clock back and loading a page.
- Reproduce a bug that only manifests when cron runs after a long gap.
- Speed up manual acceptance testing of cron-scheduled emails or notifications.
- Reset cron timing after clock/timezone changes on a development box.
