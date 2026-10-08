# Configure servers, scopes, and clients

Admin UI at `/admin/structure/oauth2-servers` (route `oauth2_server.overview`), everything gated by
permission **`administer oauth2 server`**. Three config entity types + one global config object.

## Global config object `oauth2_server.oauth`

| Key | Default | Meaning |
|---|---|---|
| `user_sub_property` | `uid` | Which user property becomes the OpenID Connect `sub` claim. Kept configurable for back-compat. |

## Server — `oauth2_server.server.*` (entity type `oauth2_server`)

Forms: add `/admin/structure/oauth2-servers/add-server`, edit `…/manage/{server}/edit`. Machine-name key
`server_id`, label `name`. `settings` mapping:

| Setting | Type | Meaning |
|---|---|---|
| `default_scope` | string | Scope granted when the request omits one (else client must specify). |
| `enforce_state` | bool | Require the OAuth `state` parameter (CSRF mitigation on authorize). |
| `allow_implicit` | bool | Enable the Implicit grant (adds a second AuthorizationCode grant instance). |
| `use_openid_connect` | bool | Issue OpenID Connect ID tokens (needs signing keys). |
| `use_crypto_tokens` | bool | Issue JWT access tokens instead of opaque DB tokens (mapped to library `use_jwt_access_tokens`). |
| `log_session_opened` | bool | Log a watchdog entry when a session/token is opened. |
| `store_encrypted_token_string` | bool | Store the token string encrypted. |
| `grant_types` | sequence | Enabled grant type ids (see below). |
| `always_issue_new_refresh_token` | bool | Refresh-token grant: rotate refresh token on each use. |
| `unset_refresh_token_after_use` | bool | Refresh-token grant: delete the old refresh token after use. |
| `advanced_settings.access_lifetime` | int | Access-token TTL (seconds). |
| `advanced_settings.id_lifetime` | int | ID-token TTL (seconds). |
| `advanced_settings.refresh_token_lifetime` | int | Refresh-token TTL (seconds). |
| `advanced_settings.require_exact_redirect_uri` | bool | Require an **exact** `redirect_uri` match (recommended; hardens against open-redirect / code interception). |

Grant type ids (`Utility::getGrantTypes()`): `authorization_code`, `client_credentials`,
`refresh_token`, `password` (User credentials), `urn:ietf:params:oauth:grant-type:jwt-bearer`, plus
`implicit` (enabled by `allow_implicit`, not listed in `grant_types`).

## Scope — `oauth2_server.scope.*` (entity type `oauth2_server_scope`)

Managed at `…/manage/{server}/scopes`. Fields: `id` (machine), `scope_id` (the scope string exposed to
clients, e.g. `email`), `server_id`, `description` (shown on the consent screen). A server needs at least
one scope; if no `default_scope` is set the client must request a scope explicitly. OpenID Connect scopes
`email` and `profile` drive extra claims (see `OAuth2Storage::getUserClaims`).

## Client — `oauth2_server.client.*` (entity type `oauth2_server_client`)

Managed at `…/manage/{server}/clients`. `config_export` fields: `client_id`, `server_id`, `name`,
`client_secret`, `public_key`, `redirect_uri`, `automatic_authorization`, `settings`, `logo_uri`,
`client_uri`, `policy_uri`, `tos_uri`.

- **`client_secret` is stored hashed.** The form passes `unhashed_client_secret`; `Client::__construct()`
  runs `hashClientSecret()` → Drupal `password` hasher. An empty secret = **public client**
  (`isPublicClient()` true; PKCE expected). `checkClientCredentials()` verifies via `PasswordInterface::check`.
- `redirect_uri`: one URI per line; the storage layer joins them with spaces for the library. Combined with
  the server's `require_exact_redirect_uri`, controls redirect validation.
- `automatic_authorization` (bool): if TRUE the authorize endpoint **skips the user consent form** and
  immediately issues the code/token for the logged-in user — only enable for fully trusted first-party clients.
- `public_key`: PEM public key used by the JWT bearer grant (`getClientKey`).
- `settings.override_grant_types` + `settings.grant_types` + `settings.allow_implicit`: per-client grant
  restriction; when `override_grant_types` is false the server's grant types apply
  (`checkRestrictedGrantType`).
- `logo_uri` / `client_uri` / `policy_uri` / `tos_uri`: shown on the consent screen.

## ID-token signing keys

`Utility::generateKeys()` uses OpenSSL (`oauth2_server.openssl.cnf`, RSA 2048, SHA-256, 2-day cert) to make
an RSA keypair, stored in `state` as `oauth2_server.keys` and published at `/oauth2/jwk` + `/oauth2/certificates`.
`oauth2_server_cron()` regenerates them if older than ~23h30m (only when a server uses crypto tokens or OIDC),
and deletes expired `oauth2_server_token` / `oauth2_server_authorization_code` entities.

## Setup outline

1. Enable module → `/admin/structure/oauth2-servers` → **Add server**; pick grant types + lifetimes.
2. Add at least one **scope** (optionally set `default_scope`).
3. Add a **client** with client_id, secret (or leave empty for a public/PKCE client), and redirect URI(s).
4. Point your OAuth client at `/oauth2/authorize` and `/oauth2/token`; for OIDC also `/oauth2/UserInfo`
   and `/oauth2/jwk`.
