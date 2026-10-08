<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Cinatra connect & tokens

**Settings:** `cinatra.settings_form` → `/admin/config/services/cinatra` (perm `administer site configuration`). Holds the Cinatra instance URL, integration credential (`api_key`), `instance_id`, and webhook secret/binding — all server-side.

**Connect handshake (ConnectController):**
- `start()` (from the settings form Connect button, Form-API CSRF): normalizes the instance URL (`CinatraUrl`), generates PKCE S256 (`Connect::pkce`) + single-use `state`, stores `{uid, instance_url, redirect_uri, code_verifier}` in a keyvalue-expirable (TTL 600s, keyed by `sha256(state)`), and 302s to the instance authorize URL.
- `callback()` (route `cinatra.connect_callback`, perm `administer site configuration`): consumes the pending state up-front (read+delete), requires `uid` match, then exchanges the code server-to-server.
- `exchange()`: runs through `ServerBase::resolve` + `Ssrf::isAllowedUrl` (blocks loopback/private/link-local/metadata), `allow_redirects=FALSE`, `http_errors=FALSE`; the returned `credential` is written to config and never returned to the browser; error bodies are never reflected.
- `installCode()`: pasted-connection-string fallback, same SSRF gate.

**Token brokers:** `cinatra.token` (`/cinatra/token`), `cinatra.widget_auth_init`, `cinatra.widget_auth_token` — POST-only, `_csrf_token: TRUE`, perm `use cinatra assistant`. They present the long-lived key to the instance server-side and return only whitelisted short-lived envelopes.

**Webhook:** `PublishWebhook` signs emissions with Standard-Webhooks `v1,<base64(hmac-sha256)>`.
