Datetime Testing is a developer API module that lets automated tests set, freeze, unfreeze, and reset the current time that Drupal reports.

---

The module decorates core's `datetime.time` service with an implementation that can override the reported "now", persisting the manipulation in the keyvalue store so it survives across the multiple requests of a functional (Behat/Nightwatch/functional-PHPUnit) test. Time can be set to any Unix timestamp or `strtotime()`-style string, frozen so it stops advancing, unfrozen so it flows again from the last set point, or reset back to the real system clock. A companion `TestDateTime` class extends `DrupalDateTime` and parses date strings relative to the manipulated time, so `new TestDateTime('now')` agrees with the manipulated clock. A Behat context adds natural-language step definitions, and Drush commands expose the same operations from the CLI. It is strictly a testing/development tool — it must not be enabled in production, has no UI/permissions/config, and carries no security-advisory coverage.

---

- Write a functional test that asserts scheduled/publish-on-date content becomes visible only after a given date by setting the clock forward before the assertion.
- Test node "published on" / "changed" timestamp behavior deterministically by pinning the time before saving.
- Verify cron-driven logic (queue expiry, scheduled tasks) by advancing the reported time and running cron.
- Test content-expiry or unpublish-after-date features by freezing time at a boundary moment.
- Assert cache max-age / expiry behavior by moving the clock past a TTL.
- Test token/session/one-time-login expiry by freezing time and stepping past the timeout.
- Reproduce timezone-sensitive rendering bugs by setting an exact `Y-m-d H:i:s` moment in a named timezone via the Drush `set` command.
- Freeze time so that two entities saved in the same test share an identical created timestamp.
- Test "X days ago" / relative-date formatters by pinning "now" and comparing rendered output.
- Exercise date-range field validation across a controlled clock (e.g. "start before end").
- Drive a Behat scenario with `Given the date is "17 May 2008 2pm"` then `When "1 hour" passes`.
- Simulate the passage of time in a Behat scenario without real `sleep()` calls, keeping tests fast.
- Reset the clock automatically at the end of each Behat scenario via the context's `@AfterScenario` hook.
- Manually set the site clock during interactive debugging with `drush datetime-testing:set '2020-01-15 12:00:00'`.
- Inspect what time Drupal currently believes it is with `drush datetime-testing:get`.
- Freeze the clock for a manual QA session with `drush datetime-testing:freeze`, then release it with `drush datetime-testing:unfreeze`.
- Restore the true system time after manual testing with `drush datetime-testing:reset`.
- Parse a user-supplied date string relative to a controlled "now" in custom test helper code via `TestDateTime`.
- Test relative-weekday logic (e.g. "next Tuesday") that core's date handling parses ambiguously.
- Keep manipulated time consistent across AJAX/sub-requests within one functional test run, thanks to keyvalue persistence.
- Assert that a workflow transition or moderation deadline fires at the correct wall-clock moment.
- Test license/subscription-expiry emails or access changes tied to a future date.
- Build regression tests around Drupal core datetime bugs by reproducing a fixed clock state.
- Provide a deterministic clock so time-based Views filters (e.g. "created in the last week") return stable results in tests.
