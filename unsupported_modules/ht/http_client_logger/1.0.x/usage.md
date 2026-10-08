<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A debugging tool that logs Guzzle HTTP client requests and responses.

---

HTTP client logger is a debugging tool which logs HTTP requests and responses made by the Guzzle HTTP client — recording outbound request/response method, URL, headers and bodies to the Drupal log, so developers can debug third-party API integrations.

**Security note:** it logs full request/response **headers and bodies without redaction** — so `Authorization` bearer tokens, `X-Api-Key` headers, and any secrets in request/response bodies are written to dblog in plaintext (readable by anyone with `access site reports`, and to any log aggregator). It is a **development tool — never leave it enabled in production**. Supports Drupal 10 and 11.

---

- Log Guzzle HTTP requests/responses.
- Record method/URL/headers/bodies.
- Aid API-integration debugging.
- Write to the Drupal log.
- NOTE: logs headers/bodies unredacted.
- Expose Authorization tokens/API keys in logs.
- Be a development tool only.
- Never enable in production.
- Depend on Drupal core only.
- Support Drupal 10 and 11.
- Aid developers.
- Debug HTTP traffic
- Support Drupal.
- Support Drupal.
- Support Drupal.
