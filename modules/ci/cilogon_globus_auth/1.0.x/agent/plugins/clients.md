<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The two OpenID Connect client plugins

Both are `@OpenIDConnectClient` plugins extending `Drupal\openid_connect\Plugin\OpenIDConnectClientBase`.
They only supply endpoints, scopes, the config form, and secret retrieval — the actual OIDC flow
(building the state token, redirect to the IdP, code→token exchange via the Drupal `http_client`,
ID-token validation, userinfo fetch, and account mapping) is inherited from `openid_connect`.

## OSPCILogon — `src/Plugin/OpenIDConnectClient/OSPCILogon.php`

- Plugin id **`ospclscigw`**, label "CILogon (OSP)".
- `defaultConfiguration()`: `authorization_endpoint` `https://cilogon.org/authorize`,
  `token_endpoint` `https://cilogon.org/oauth2/token`, `userinfo_endpoint`
  `https://cilogon.org/oauth2/userinfo`, `requested_scopes`
  `email,openid,profile,org.cilogon.userinfo`, empty `client_id`/`client_secret`.
- `buildConfigurationForm()`: Client ID (textfield). Client Secret is a **`key_select`** filtered to
  `type => authentication` when the **`key`** module is enabled, otherwise a plain required textfield.
  Endpoints and scopes are editable textfields.
- `getClientSecret()`: if `key` is enabled and a key id is stored, loads the Key value via
  `key.repository`; otherwise returns the stored string.
- `getRequestOptions()`: token request `form_params` = `code`, `client_id`, `client_secret`
  (from `getClientSecret()`), `redirect_uri`, `grant_type=authorization_code`; `Accept: application/json`.
- `getClientScopes()`: splits `requested_scopes` on commas and trims.
- `authenticate($authorization_code)`: a **non-standard override** that exchanges tokens
  (`retrieveTokens`), fetches userinfo (`retrieveUserInfo`), derives `authname` from `sub` and
  `idp_name` (default `"CILogon"`), then writes an `externalauth.authmap` record. The openid_connect
  v3 completion flow does not call a plugin `authenticate()` method, so in normal operation the
  inherited flow handles mapping and this method is effectively unused legacy code.

## OSPGlobusAuth — `src/Plugin/OpenIDConnectClient/OSPGlobusAuth.php`

- Plugin id **`ospgascigw`**, label "Globus Auth (OSP)".
- Unlike CILogon it defines a full constructor + `create()` to inject `module_handler` and
  `key.repository` (rather than fetching `key` via `\Drupal::service()`), passing the remaining
  services through to `OpenIDConnectClientBase`.
- `defaultConfiguration()`: authorize `https://auth.globus.org/v2/oauth2/authorize`, token
  `.../v2/oauth2/token`, userinfo `.../v2/oauth2/userinfo`, `end_session_endpoint`
  `https://auth.globus.org/v2/web/logout`, `requested_scopes` `openid email`, plus empty
  `session_required_policies`, `session_required_single_domain`, `session_message`.
- `buildConfigurationForm()`: same Client ID / key-aware Client Secret / endpoints / scopes as
  CILogon, plus an **End session endpoint** and three Globus-specific fields:
  - `session_required_policies` — comma-separated Globus Auth policy UUID(s).
  - `session_required_single_domain` — comma-separated identity domain(s) (e.g. `ucsd.edu,ucla.edu`).
  - `session_message` — plain-text message shown on Globus's auth screens (maxlength 256).
- `validateConfigurationForm()`: rejects setting BOTH `session_required_policies` and
  `session_required_single_domain` (Globus disallows both in one request).
- `authorize()` **override**: builds the authorize redirect via the inherited `getUrlOptions()`
  (which includes the OIDC **state** token), then appends any configured `session_required_policies`,
  `session_required_single_domain` (only when no policy is set), and `session_message` to the query.
  Removes the `destination` query param, returns a `TrustedRedirectResponse`, and triggers the page
  cache kill switch so the state is written to the session. Emits a `debug`-level log of the outbound
  authorize URL.
- `getEndpoints()` also returns `end_session` (falls back to the Globus web-logout URL for configs
  saved before the key existed). `getClientSecret()` / `getRequestOptions()` / `getClientScopes()`
  mirror CILogon (secret via injected `keyRepository`).

## Transfer-token session — `src/OSPOpenIDConnectSession.php`

`OSPOpenIDConnectSession extends OpenIDConnectSession` (service
`cilogon_globus_auth.openid_connect.session`). Adds `saveTransferTokens(array)` /
`retrieveTransferTokens(bool $clear)` storing a Globus Transfer token bundle under the session key
`openid_connect_transfer`. Purely session-scoped helpers for downstream Globus Transfer API use.
