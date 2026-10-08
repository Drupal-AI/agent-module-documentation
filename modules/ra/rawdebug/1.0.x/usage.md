<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
RawDebug provides debugging functions to log to a file.

---

RawDebug provides **debugging helper functions that log variables/data to a file** — quick `dump`-style
helpers for developers to inspect data during development without a full debugger. It is in the Development
package.

Use it only in development to inspect data. It is a developer/debugging tool. Security/operational caution: it
**writes potentially sensitive data to a log file** — never leave it on **production** (logged data could
include PII/secrets and the log file could be exposed), and remove debug calls before deploying. It has no
content or access role. Use its helpers during development.

---

- Log variables/data to a file.
- Provide dump-style helpers.
- Inspect data in development.
- Serve development.
- Aid debugging.
- Log data quickly.
- WRITE potentially sensitive data to a log.
- Never leave it on production.
- Remove debug calls before deploying.
- Have no content/access role.
- Use it in development.
- Handle debug logging.
- Log data.
- Configure nothing (dev).
- Dump variables.
- Handle the logs.
- Debug data.
- Inspect data.
- Disable in production.
- Provide debug logging.
