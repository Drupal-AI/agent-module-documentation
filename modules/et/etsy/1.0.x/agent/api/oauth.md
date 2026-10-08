<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OAuth2 authentication (plugin + provider)

Authentication is delegated to the contrib **`oauth2_client`** module. This module supplies an `Oauth2Client` plugin and a League provider; the OAuth flow, credential entry, callback and refresh are oauth2_client's responsibility — `etsy` has no OAuth callback route of its own.

## Plugin — `Drupal\etsy\Plugin\Oauth2Client\Etsy`

File `src/Plugin/Oauth2Client/Etsy.php`, annotation `@Oauth2Client`:

- `id = "etsy"`, `grant_type = "authorization_code"`.
- `authorization_uri = https://www.etsy.com/oauth/connect`, `token_uri = https://api.etsy.com/v3/public/oauth/token`, `resource_owner_uri = ""`.
- Scopes: the full Etsy scope set (address_r/w, billing_r, cart_r/w, email_r, favorites_r/w, feedback_r, listings_d/r/w, profile_r/w, recommend_r/w, shops_r/w, transactions_r/w), `scope_separator = " "`.
- `success_message = FALSE`.

Token storage (overrides base):
- `storeAccessToken()` → `state->set('oauth2_client_access_token-etsy', $accessToken)`.
- `retrieveAccessToken()` → `state->get('oauth2_client_access_token-etsy')`.
- `clearAccessToken()` → `state->delete(...)`.

So the **access token lives in Drupal `state`** (not config, not exported). `getProvider()` builds an `EtsyProvider` from `getClientId()`, `getClientSecret()`, `getRedirectUri()`, the URIs and scopes above, with `pkceMethod = 'S256'`.

## Provider — `Drupal\etsy\Provider\EtsyProvider`

File `src/Provider/EtsyProvider.php`, extends League `GenericProvider`. Overrides `getAuthorizationParameters()` to add Etsy specifics: it sets a random `state` when none is supplied (`getRandomState()`), adds `response_type=code` and `approval_prompt=auto`, imploded scopes, `client_id`, `redirect_uri`, and the PKCE `code_challenge`/`code_challenge_method`. The token exchange still sends the OAuth2 `client_secret` (League default), so the shared secret gates the code exchange.

## Where credentials come from (verified — no env/getenv/Key recipe)

- The **Client ID (Etsy keystring)** and **Client Secret (Etsy shared secret)** are entered into the oauth2_client **config entity** `oauth2_client.oauth2_client.etsy` at **`/admin/config/system/oauth2-client`** (edit the "etsy" client, enable it, fill Client ID / Client Secret, "Save and request token"). They are stored by the oauth2_client module (plain config), not by this module and not in an environment variable, dotenv, `getenv()`, or a Key entity.
- `config/install/oauth2_client.oauth2_client.etsy.yml` pre-creates that client with `oauth2_client_plugin_id: etsy`, `credential_provider: oauth2_client`, empty `credential_storage_key`.
- `etsy_uninstall()` deletes both `etsy.settings` and `oauth2_client.oauth2_client.etsy`.

## Keeping the token alive

`hook_cron` (`etsy_cron`, and also `etsy_shop_cron`) calls `etsy.api::ping()` each run so the OAuth2 access token is refreshed/kept valid by oauth2_client.
