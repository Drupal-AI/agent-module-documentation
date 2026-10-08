<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a logger wrapper that emits any given log message only once per request, collapsing repeated identical entries.

---
Modules that log inside loops or hot code paths can flood the log with the same message dozens of times in a single request. Unique Logs solves this by wrapping the standard logger factory in a `unique_logs.logger` service that tracks messages it has already seen during the current PHP request and drops exact duplicates, so the log keeps one representative entry instead of many. It is a small developer utility with no routes, permissions, config or UI — you call the service from your own code exactly where you would otherwise call `\Drupal::logger()`.

There is no security surface: the module ships only a service definition and a `Logger` class, performs no HTTP, and stores nothing beyond in-request bookkeeping. Setup is simply enabling the module and swapping your logging calls to the provided service.
---
- Log a message only once per request even when called in a loop.
- Suppress duplicate warnings emitted from hot code paths.
- Keep the log readable during batch/iterative processing.
- Wrap the standard logger factory with dedup behaviour.
- Use as a drop-in replacement for `\Drupal::logger()` in noisy code.
- Reduce log volume without changing log severity levels.
- Debug loops without flooding the watchdog table.
- Call `unique_logs.logger` from a custom service or controller.
- Avoid repeated identical entries in dblog/syslog.
- Keep error-tracking noise down during migrations.
- Cut down redundant notices during cron runs.
- Inject the logger service instead of the default channel.
- Keep one representative entry per distinct message.
- Trim log spam without editing severity thresholds.
- Log deprecation notices once instead of per iteration.
- Quiet repeated validation warnings in bulk imports.
