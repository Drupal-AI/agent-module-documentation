<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Request Logger allows you to parse and log all incoming JSON:API requests.

---

JSON:API Request Logger logs incoming JSON:API requests — recording configurable details (method, URL,
status code, headers, query, request body) via a request event subscriber, for debugging/auditing API
traffic. It provides its own permissions, in the Development package, and lets you customize the log format
with tokens (`{method}`, `{url}`, `{status_code}`, `{headers}`, `{query}`, `{content}`).

Use it to debug/inspect JSON:API traffic. **Security caveat — be careful which tokens you log.** The
`{headers}` token logs the request headers, which include the **`Authorization` header (bearer tokens /
basic-auth credentials) and cookies (session)**; the `{content}` token logs the request **body (which may
contain PII)**. So including those tokens writes **credentials/session tokens/PII into the Drupal log**
(dblog), where they're readable by anyone with `access site reports` and may be retained/shipped to log
aggregators. Therefore: avoid logging `{headers}`/`{content}` unless you've accepted that consequence,
redact sensitive headers, restrict who can read the logs, and disable this on production (it's a
development/debugging tool). It has no access-control role. Configure the log format carefully.

---

- Log incoming JSON:API requests.
- Record method/url/status/headers/body.
- Debug/audit API traffic.
- Provide its own permissions.
- Customize the log format with tokens.
- Use a request event subscriber.
- CAVEAT: {headers} logs Authorization/cookies (credentials).
- CAVEAT: {content} logs the request body (PII).
- Avoid logging {headers}/{content} unless accepted.
- Redact sensitive headers.
- Restrict who can read the logs.
- Disable on production (dev/debug tool).
- Have no access-control role.
- Configure the log format carefully.
- Handle request logging.
- Log JSON:API traffic.
- Configure logging.
- Inspect API requests.
- Not log credentials/PII.
- Handle the logger.
