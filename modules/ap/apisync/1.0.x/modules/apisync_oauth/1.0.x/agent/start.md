<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Api Sync oAuth Module (apisync_oauth) — agent index

Submodule of [apisync](../../../../1.0.x/agent/start.md). Ships one token-based auth provider plugin. Package `liip`, core `^9.1 || ^10 || ^11`, PHP `>=8.1`. Depends on **`oauth2_client`** (contrib). No services/routes/permissions/schema of its own.

## What it provides
- **Auth plugin** `Drupal\apisync_oauth\Plugin\ApiSyncAuthProvider\ApiSyncOAuthPlugin` — `@Plugin(id="apisync_oauth", label="oAuth2 Authentication")`, extends `ApiSyncAuthProviderPluginBase`, `ContainerFactoryPluginInterface` (injects `oauth2_client.service` and `entity_type.manager`).
  - `isTokenBasedProvider(): TRUE`.
  - `defaultConfiguration()`: `client_id => NULL`.
  - `buildConfigurationForm()`: a `select` of available `oauth2_client` entities (via the oauth2_client list builder).
  - `getAccessToken()`: `oauth2ClientService->getAccessToken($client_id, NULL)?->getToken()` (wrapped in try/catch for `InvalidOauth2ClientException`).
  - `appendAuthHeaders()`: `Authorization: 'Bearer ' . getAccessToken()`; throws `IdentityNotFoundException` if empty.
  - `clearAccessToken()` / `refreshAccessToken()`: clear then re-fetch (no revoke — client-credentials tokens are simply re-issued).
  - `validateConfigurationForm()`: clears + re-fetches a token to prove the client is active/configured.

## Design note
The OAuth exchange (token endpoint, client id/secret, grant) lives entirely in the `oauth2_client` module and its client entity — this plugin only picks a client id and reads the resulting bearer token. The client secret is stored/managed by `oauth2_client` (Key-capable), not in API Sync config.

## Configure
1. Enable `oauth2_client` and this module. 2. Create an `oauth2_client` client (endpoints, credentials). 3. At `/admin/config/apisync/authorize`, add an `apisync_auth` config, choose **oAuth2 Authentication**, select the client, save as default.
