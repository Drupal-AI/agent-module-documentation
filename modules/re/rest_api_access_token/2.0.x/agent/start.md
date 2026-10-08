<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST API Access Token — agent index

Token-based **authentication provider** for the Drupal REST/JSON:API. Clients log in for a `public`/`secret` token, then send `X-AUTH-TOKEN` on requests. Optional per-request signature verification and per-user response cache (both OFF by default). Config UI at `/admin/config/system/rest_api_access_token` (`configure` = `rest_api_access_token.config_form`, permission `administer rest api access token`). No config schema, no Drush; a `cron` hook prunes expired tokens.

- **Endpoints, request headers, the signature formula, events, response cache, token generation** → [api/endpoints.md](api/endpoints.md)
- **Config form settings (login-by-name/mail, signature, cache, lifetimes) and defaults** → [configure/settings.md](configure/settings.md)

Key facts:
- Login `POST api/v1/auth/token` (anonymous) → `{token, secret, userId}`. Logout `POST api/v1/auth/logout` and `.../logout-from-all-devices` (token-authed).
- Auth provider `AccessTokenProvider` is `global: TRUE`, priority 101; `applies()` when `X-AUTH-TOKEN` is in a **header OR query string**.
- Tokens: `hash('sha256', bin2hex(random_bytes(64|32)))`; stored in table `rest_api_access_token` (PK `public_token`).
- Signature (opt-in): `X-AUTH-SIGNATURE = sha256("token|REQUEST-ID|path|base64(body)|secret")`.
- Auth token is also accepted from the URL query string; secret/signature off by default.
