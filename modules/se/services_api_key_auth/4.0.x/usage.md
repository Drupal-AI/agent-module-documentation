<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Request API Key Authentication adds an API-key authentication provider to Drupal, so a machine caller can authenticate to REST or JSON:API by sending a key in a request header (or, if configured, a POST or GET parameter) instead of a browser session or basic auth.

---

Decoupled front ends and server-to-server integrations need an authentication method that is not a browser session, and one that does not put a user password in every request the way HTTP basic auth does. This module defines an `api_key` configuration entity — created and managed at `/admin/config/services/api-key-auth` under the permission `administer services_api_key_auth` — where each key is bound to a Drupal user via that user's UUID. It registers an authentication provider (`provider_id: api_key_auth`, service `services_api_key_auth.authentication.api_key_auth`) that resolves an incoming key to its entity and then to the bound user, so the request runs with that account's permissions. A settings form (`services_api_key_auth.settings`) chooses where the key is read from: `api_key_request_header_name` (default `api_key`), `api_key_post_parameter_name`, and `api_key_get_parameter_name`, each disabled when left empty. The provider is checked first-by-priority and is not global, so JSON:API accepts it automatically while core REST resources opt in by listing `api_key_auth` in their authentication set. The add form pre-fills a freshly generated 32-character key (`substr(hash('sha256', random_bytes(16)), 0, 32)`), which an administrator may keep or replace. The module is minimally maintained, targets Drupal `^10.3 || ^11`, and has no other module dependencies.

---

- Authenticate a decoupled front end to Drupal.
- Give a server-to-server integration its own key.
- Avoid sending a user password on every API request.
- Bind an API key to a specific Drupal account.
- Revoke a key by deleting its entity, without changing a password.
- Issue separate keys per consumer or partner system.
- Authenticate JSON:API requests from a script.
- Support a headless or single-page application backend.
- Run API requests with a specific user's role permissions.
- Rotate a key without redeploying the consumer's session logic.
- Read the key from a request header by default.
- Optionally read the key from a POST body field.
- Optionally read the key from a query-string parameter.
- Enable API-key auth on a specific core REST resource.
- Authenticate a scheduled import or cron-triggered job.
- Provide a mobile app backend with a non-session credential.
- Separate machine access from human login accounts.
- Manage keys from an admin UI list.
- Replace basic auth on an internal API.
- Generate a strong random key from the admin form.
- Audit which key belongs to which integration by label.
- Restrict who can create keys via one admin permission.
