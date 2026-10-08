<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Watchdog File writes Drupal watchdog log events to a local flat file, usable as a replacement for the core Database Logging (dblog) module.

---

Watchdog File writes Drupal's watchdog log events to a local flat file instead of (or alongside)
the database — a lighter-weight logging backend than core Database Logging (dblog), avoiding log writes
to the database and making logs easy to tail or ship to external log tooling. It is positioned as a
dblog replacement in the "Performance and scalability" package.

Use it to reduce database log load or to integrate with file-based log pipelines (logrotate, a log
shipper, a SIEM). The key operational/security consideration is the **log file location and
permissions**: place the log file **outside the web root** and ensure it is not web-servable, since
Drupal logs can contain sensitive details (paths, user info, error internals) that must not be publicly
retrievable. Also manage rotation so the file doesn't grow unbounded. It changes where logs go, not
access to the site.

---

- Write watchdog logs to a flat file.
- Replace Database Logging (dblog).
- Reduce database log load.
- Ship logs to external tooling.
- Tail logs from a file.
- Integrate with logrotate/SIEM.
- Place the log file outside the web root.
- Ensure the log file is not web-servable.
- Protect sensitive log contents.
- Manage log rotation.
- Avoid unbounded log growth.
- Use file-based logging.
- Lighten logging overhead.
- Position as a dblog alternative.
- Keep logs off the database.
- Feed a log pipeline.
- Change where logs go, not access.
- Store logs locally.
- Support performance/scalability.
- Secure the log file location.
