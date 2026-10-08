<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
RESTful Logger provides a REST resource for logging messages into the Drupal watchdog/dblog.

---

RESTful Logger provides a REST resource for logging — letting an external/authenticated client POST a
log message (with severity) that is written into Drupal's logger (watchdog/dblog), useful for centralizing
logs from decoupled front ends or integrations into Drupal's log. It depends on core REST, provides its own
permissions, in the Web services package.

Use it to let trusted systems push log entries into Drupal. Its access is correctly gated: the POST handler
checks the `post log messages` permission before logging. Keep that permission **restricted to trusted
integrations** — a client that can post logs could otherwise spam/flood the log or inject misleading entries
(log spam/injection), so grant it narrowly and consider rate-limiting. As always, ensure clients don't push
sensitive data into logs. It has no other access-control role. Configure the REST resource and permission.

---

- Provide a REST resource for logging.
- POST log messages into Drupal.
- Write to watchdog/dblog.
- Depend on core REST.
- Provide its own permissions.
- Centralize decoupled/integration logs.
- Gate POST by the 'post log messages' permission.
- Restrict the permission to trusted integrations.
- Avoid log spam/injection from over-granting.
- Consider rate-limiting.
- Not push sensitive data into logs.
- Have no other access-control role.
- Configure the REST resource.
- Handle REST logging.
- Push log entries.
- Log via REST.
- Configure the permission.
- Handle external logs.
- Restrict log posting.
- Log messages.
