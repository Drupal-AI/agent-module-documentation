<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# editionguard_api — configuration

At `/admin/config/services/editionguard-api` set:
- `oauth_email`, `oauth_password` — EditionGuard account credentials (stored in
  `editionguard_api.settings` config; treat exported config as secret).
- `token_expire` — lifespan applied to the cached access token.
- `logging_enabled` — logs requests/responses to the `editionguard_api` channel.

`/test` and `/test/endpoint/{endpoint_id}` let an admin exercise endpoints.
Token exchange and all calls go to `https://app.editionguard.com/api/v2/`
over HTTPS with Guzzle default certificate verification.
