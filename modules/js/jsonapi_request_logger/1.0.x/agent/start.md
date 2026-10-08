<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Request Logger — agent index

Logs incoming **JSON:API requests** (configurable `{method}/{url}/{status_code}/{headers}/{query}/{content}`
tokens). Provides permissions. Version **1.0.2**. Core `^9||^10||^11`.

**SECURITY CAVEAT:** `{headers}` logs the **`Authorization` header (bearer/basic creds) + cookies**;
`{content}` logs the **request body (PII)** — including them writes **credentials/session tokens/PII into
dblog** (readable by `access site reports`, retained/shipped). Avoid those tokens unless accepted; redact;
restrict log access; **disable on production** (dev/debug tool). No access role.
