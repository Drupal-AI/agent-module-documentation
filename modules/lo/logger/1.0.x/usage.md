<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Logger provides a Drupal logger that can store custom additional metadata per log entry and write to database, file, syslog, or stdout/stderr (for containers).

---

Logger provides a flexible logging backend for Drupal — able to store arbitrary custom metadata
alongside each log entry and write logs to multiple destinations: database, file, syslog, or stdout/stderr
(the last useful for containerized deployments where logs go to the container's output). It is in the
Logging package.

Use it for structured logging with custom context, especially in containerized/observability setups. It is
a developer/logging feature. As with any logging, be mindful that log entries (and the custom metadata) can
contain sensitive detail — avoid logging secrets/PII, and if writing to file, place the log outside the web
root and not web-servable. It has no content-access role. Configure the log destinations and metadata.

---

- Log with custom metadata.
- Write logs to database.
- Write logs to file.
- Write logs to syslog.
- Write to stdout/stderr for containers.
- Store structured log context.
- Support observability setups.
- Avoid logging secrets/PII.
- Place file logs outside the web root.
- Not make log files web-servable.
- Have no content-access role.
- Configure log destinations.
- Add custom log metadata.
- Support container logging.
- Log to multiple destinations.
- Handle structured logging.
- Configure metadata.
- Route logs flexibly.
- Log to stdout.
- Provide flexible logging.
