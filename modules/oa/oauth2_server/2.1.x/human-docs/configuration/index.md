# Configuration

Everything is managed under **Structure → OAuth2 Servers**
(`/admin/structure/oauth2-servers`), which requires the **Administer OAuth2 server**
permission. You build up the configuration in three layers: a server, its scopes, then
clients.

## 1. Add a server

Click **Add server** and give it a name and machine name. The key settings are:

- **Grant types** — tick the OAuth flows this server supports:
  - *Authorization code* — the standard user-login flow with a consent screen.
  - *Client credentials* — machine-to-machine access, no user involved.
  - *Refresh token* — lets clients renew access tokens.
  - *User credentials (password)* — for trusted first-party apps.
  - *JWT bearer* — uses a client's registered public key.
  - *Implicit* — legacy browser-based flow (enabled by its own "Allow implicit"
    option).
- **Default scope** — the scope granted when a request does not name one (otherwise the
  client must specify a scope).
- **Enforce state** — require the OAuth `state` parameter on the authorize endpoint
  (CSRF protection — recommended).
- **Use OpenID Connect** — issue OIDC ID tokens (requires signing keys, which the
  module manages for you).
- **Use crypto tokens** — issue JWT access tokens instead of opaque database tokens.
- **Advanced settings** — token lifetimes (**access token**, **ID token**, **refresh
  token**), refresh-token rotation options, and **Require exact redirect URI**.
  Turning on *Require exact redirect URI* is recommended: it hardens against
  open-redirect and code-interception attacks by demanding an exact match of the
  client's registered redirect URI.

## 2. Add scopes

On the server's **Scopes** tab, add at least one scope. Each scope has a machine ID, a
**scope string** exposed to clients (for example `email` or `profile`), and a
**description** shown on the consent screen. If you do not set a default scope on the
server, clients must request a scope explicitly. The OpenID Connect scopes `email` and
`profile` drive the extra claims returned from the UserInfo endpoint.

## 3. Register a client

On the server's **Clients** tab, add a client for each connecting application:

- **Client ID** and **Client secret** — the credentials the application uses. The
  secret is stored **hashed**; leaving it empty makes a **public client** (which is
  expected to use PKCE). On the application side, keep the secret in an environment
  variable, never in committed code.
- **Redirect URI(s)** — one per line. Combined with the server's *Require exact
  redirect URI* setting, this controls where authorization responses may be sent.
- **Automatic authorization** — when on, the authorize endpoint **skips the user
  consent screen** and immediately issues the code/token. Only enable this for fully
  trusted first-party clients.
- **Public key** — a PEM public key used by the JWT bearer grant.
- **Per-client grant types** — optionally restrict this client to a subset of the
  server's grant types.
- **Logo / client / policy / terms URIs** — shown on the consent screen.

## The OAuth endpoints

Point your client application at these routes (serve them over HTTPS):

| Endpoint | Purpose |
|----------|---------|
| `/oauth2/authorize` | Authorize endpoint — where the user logs in and consents. |
| `/oauth2/token` | Token endpoint — exchanges a code/credentials for tokens. |
| `/oauth2/UserInfo` | OpenID Connect UserInfo — claims for the bearer token's scopes. |
| `/oauth2/revoke` | Revoke a token. |
| `/oauth2/tokens/{token}` | Introspect an access token you already hold. |
| `/oauth2/jwk` and `/oauth2/certificates` | Public signing key (JWK) and X.509 certificate — intentionally public, so clients can verify tokens. |

## Signing keys

For OpenID Connect and JWT access tokens, the module generates an RSA keypair with
OpenSSL, publishes the public half at `/oauth2/jwk` and `/oauth2/certificates`, and
**rotates it automatically about once a day on cron** (following Google's practice).
Cron also deletes expired tokens and authorization codes. Make sure cron runs
regularly.

## Permissions

Under **People → Permissions**:

- **Administer OAuth2 server** — full management of servers, scopes, and clients.
  Because it controls who can mint clients, secrets, and grant types, treat it as a
  trusted, admin-level permission.
- **Use OAuth2 server** — required to reach the authorize/token/UserInfo/revoke
  endpoints. Grant it to the roles whose users are allowed to log into external apps
  via OAuth (commonly *Authenticated user*). Granting it does **not** let a user manage
  the server.

The `/oauth2/jwk` and `/oauth2/certificates` endpoints are public by design — they
expose only the public key.

## Protecting your own routes with access tokens

The module registers an `oauth2` authentication provider, so you can protect a custom
API route by accepting `Authorization: Bearer <access_token>`:

```yaml
my_module.api:
  path: '/my/api'
  defaults: { _controller: '\Drupal\my_module\Controller\Api::data' }
  options:
    _auth: ['oauth2']
  requirements:
    _permission: 'access content'
```

To verify a token and scope inside custom code, use `Utility::checkAccess($server_id,
$scope)` — see the sibling [`agent/`](../agent/start.md) docs for the details and for
the claim/scope hooks.
