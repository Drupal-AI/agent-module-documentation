Audit analyzer that scores the dblog watchdog table, grouping errors/warnings by time bucket (24h, week, older).

---

audit_watchdog registers the `watchdog` AuditAnalyzer plugin (WatchdogAnalyzer) and depends on core dblog. It queries the {watchdog} table (parameterised UNION ALL across three time buckets — last 24 hours, last week, older) to aggregate the most frequent messages by type/severity, scoring each bucket, and surfaces recurring PHP errors and warnings. Watchdog message variables are unserialized with a strict class allow-list and messages are strip_tags-truncated before display. An informational overview summarizes log volume. Ships no config of its own.

---

- Aggregate the most frequent watchdog errors/warnings over the last 24 hours.
- Compare recent (24h/week) vs older log noise to spot regressions.
- Surface recurring PHP errors that indicate real code defects.
- Score logging health as part of the overall Project Score.
- Identify a runaway error flooding the log after a deploy.
- Group messages by type and severity to prioritize fixes.
- Include log health in a takeover audit of an unfamiliar site.
- Run headless via `drush audit:run watchdog --format=json`.
- Monitor error trends across a portfolio via DruScan.
- Detect noisy but non-critical warnings worth silencing.
- Get a quick overview of total log volume by bucket.
- Spot security-relevant log patterns (access denied, PHP notices).
- Provide ops a scored log summary without granting dblog access.
- Feed a weighted logging score into the overall Project Score.
- Skip gracefully with a requirement warning when dblog is disabled.
