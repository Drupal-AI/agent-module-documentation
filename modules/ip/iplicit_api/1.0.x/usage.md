<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Authenticated HTTP client service for the Iplicit accounting API: session-token handling, mandatory Domain header, and Key-based secret storage.

---

Iplicit API provides a generic, authenticated client service for the Iplicit accounting API so other modules can call Iplicit without handling session tokens, the mandatory `Domain` header, or credential storage themselves.

The API key is a secret stored via the Key module (Environment variable or File provider recommended) — only the key *ID* is saved in `iplicit_api.settings`, so `config:export` never writes the secret to `config/sync`. `CredentialProvider` resolves the connection (base URI, domain, username, key, timeout) and throws a configuration exception when anything is missing; `HttpClientBuilder` builds a Guzzle client via core's `ClientFactory` (default TLS verification — no `verify => false`) with the `Domain` default header; `SessionManager` exchanges the key for a bearer session token at `/api/Session/create/api`, caches it in `cache.default` capped at 30 minutes keyed by a fingerprint of the connection settings, and discards it when Iplicit rejects it. Debug logging records only metadata (domain, version, expiry) — never the token or key. A settings form at `/admin/config/services/iplicit` (permission `administer iplicit api`, restricted) configures and test-connects the client.

This module ships no business logic (no Commerce dependency); consumer modules depend on it and wrap the resource classes they need. Typical setup: install Key, create a Key holding the Iplicit API key from an env var/file, configure the connection, and press Test connection.
---
- Provide a shared authenticated Iplicit client to other modules.
- Store the Iplicit API key as a Key entity, never in config.
- Keep the secret out of `config/sync` (only the key ID is exported).
- Configure base URI, domain, username, key and timeout.
- Test the connection from the settings form.
- Obtain and cache a bearer session token automatically.
- Apply the mandatory `Domain` header on every request.
- Cap the cached session at 30 minutes regardless of API expiry.
- Key the session cache by a connection fingerprint.
- Invalidate a stale token when Iplicit rejects it.
- Override connection settings per environment in settings.php.
- Turn the whole client off with the `enabled` switch.
- Log only session metadata when debug is enabled.
- Build a Commerce-to-Iplicit invoice push in a separate module.
- Reuse resource wrapper classes over the client.
- Fail safe in background jobs via `isConfigured()`.
