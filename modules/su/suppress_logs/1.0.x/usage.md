<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Suppress Logs suppresses unneeded logs by decorating the logger factory to drop configured log messages.

---

Suppress Logs reduces log noise — decorating Drupal's `logger.factory` so that configured (unneeded) log
messages are dropped (routed to a null logger) rather than written to dblog/watchdog, keeping the log focused
on what matters. It is configured at `suppress_logs.settings_form`, provides its own permissions, in the
Performance package.

Use it to cut noisy, low-value log entries. **Important caveat: suppressing logs can hide security-relevant
events.** Logs of failed logins, access-denied, exceptions and similar are exactly what you rely on to detect
attacks and for forensics/incident response — so be **selective**: suppress only genuinely noise (a specific
noisy channel/message), and **never broadly suppress security, error or audit channels**. Over-suppression
reduces your ability to detect and investigate incidents. Keep the suppression config tight and reviewed. It
has no access-control role. Configure exactly which messages to suppress.

---

- Suppress configured (unneeded) log messages.
- Reduce log noise.
- Decorate the logger factory.
- Drop configured messages to a null logger.
- Configure at suppress_logs.settings_form.
- Provide its own permissions.
- CAUTION: suppressing logs can hide security events.
- Be selective (suppress only genuine noise).
- Never broadly suppress security/error/audit channels.
- Keep the config tight and reviewed.
- Preserve detectability/forensics.
- Have no access-control role.
- Configure exactly what to suppress.
- Cut low-value entries.
- Handle log suppression.
- Reduce noise carefully.
- Suppress noise only.
- Configure suppression.
- Avoid over-suppression.
- Focus the log.
