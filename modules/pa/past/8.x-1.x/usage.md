<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Past provides logging capabilities to log events with arguments in a normalized way, with database and form submodules.

---

Past provides a structured event-logging framework — logging events with arguments/metadata in a
normalized, queryable way (beyond simple watchdog text messages), useful for auditing and debugging complex
flows. It ships `past_db` (database backend), `past_form`, and test submodules, and provides its own
permissions.

Use it for richer, structured logging of application events. As with any logging framework, be mindful that
logged event arguments can contain sensitive data (avoid logging secrets/PII), and access to the logged
events should be permission-gated (event logs can reveal internal detail). It is a developer/logging feature
with no content-access role beyond its permission. Configure what is logged and the backend.

---

- Log events with normalized arguments.
- Provide structured logging.
- Query logged events.
- Use the past_db backend.
- Provide its own permissions.
- Log richer than watchdog text.
- Audit complex flows.
- Avoid logging secrets/PII in arguments.
- Gate access to event logs.
- Have no content-access role beyond permission.
- Configure what is logged.
- Log application events.
- Store event metadata.
- Debug with structured logs.
- Use for auditing.
- Normalize log arguments.
- Handle event logging.
- Configure the backend.
- Log structured data.
- Provide logging framework.
