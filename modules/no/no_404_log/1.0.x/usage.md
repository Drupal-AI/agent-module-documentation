<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
No 404 Log suppresses or filters 404 log entries.

---

No 404 Log **suppresses or filters 404 (page not found) log entries** — cutting the noise that
missing-page requests (bots, scanners, stale links) generate in Drupal's logs, optionally by pattern, in the
Logging package.

Use it to keep logs readable on sites hit by many 404s. It is an operations/logging feature. Security note:
404s can also be a signal of scanning/probing — if you suppress them, make sure you still capture what you need
for security monitoring (e.g. filter narrowly rather than dropping all 404s). It has no access-control role.
Configure the 404-logging filter.

---

- Suppress/filter 404 log entries.
- Reduce log noise.
- Filter by pattern.
- Serve logging/operations.
- Cut bot/scanner noise.
- Keep logs readable.
- KNOW 404s can signal scanning.
- Filter narrowly, not drop-all.
- Preserve security monitoring signal.
- Have no access-control role.
- Configure the filter.
- Handle 404 logging.
- Filter 404s.
- Configure the logging.
- Suppress 404s.
- Handle the logs.
- Reduce noise.
- Filter logs.
- Set the filter.
- Provide 404-log filtering.
