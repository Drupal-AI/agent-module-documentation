# Configuration

Configuring Monitoring SSO means configuring the bundled OAuth2 Server: you create
a **server**, define the **scopes** clients may request, register the **clients**
(the applications that will use your site to log people in), and grant the right
permissions. All of this lives under **Structure → OAuth2 Servers**
(`/admin/structure/oauth2-servers`).

> **Before you start:** remember this is a development fork. For a production
> OAuth2/OIDC provider, use the canonical OAuth2 Server module. The steps below
> describe the standard OAuth2 Server workflow that this bundle inherits.

## 1. Create a server

1. Log in as a user with the **Administer OAuth2 Server** permission.
2. Go to **Structure → OAuth2 Servers** and add a new server.
3. Give it a **label** and **machine name**, and configure its token settings —
   for example the access token and refresh token lifetimes, and whether to enable
   **OpenID Connect** (which issues signed ID tokens using the site's RSA private
   key, published for verification at `/oauth2/jwk` and `/oauth2/certificates`).

## 2. Define scopes

Within the server, define the **scopes** that clients are allowed to request.
Scopes are the fine‑grained permissions a client asks the user to consent to (for
example a basic profile scope). Mark a default scope if appropriate.

## 3. Register clients

Add an OAuth2 **client** for each application that will authenticate against your
site. For each client you typically set:

- **Label / client ID** — how the client identifies itself.
- **Client secret** — the shared secret used on the token endpoint. This is
  sensitive credential material; keep it secret and rotate it if leaked.
- **Redirect URI(s)** — the exact URLs your site is allowed to send the user back
  to after authorization. Restrict these tightly.
- **Grant types** — which flows the client may use (for example
  authorization_code, client_credentials).
- **Automatic authorization** — optionally skip the consent screen for trusted
  first‑party clients.

## 4. Grant permissions

On **People → Permissions** (`/admin/people/permissions`):

- Grant **Use OAuth2 Server** to the roles whose users are allowed to authorize
  clients and obtain tokens (this gates `/oauth2/authorize` and `/oauth2/token`).
- Keep **Administer OAuth2 Server** restricted to administrators only — it controls
  server, scope, and client configuration.

## Secrets and keys

- The **client secret** and the server's **RSA private signing key** are
  sensitive. Store keys outside the web root and out of version control; only the
  public key is meant to be exposed (via `/oauth2/jwk` and `/oauth2/certificates`).
- If you manage secrets as environment variables in DDEV, set them with
  `ddev dotenv set .ddev/.env --oauth-...=<value>` (keep `.ddev/.env` out of
  version control) and `ddev restart`, then reference them from your key storage.

## The endpoints

Once configured, clients interact with these routes:

- `/oauth2/authorize` — start the authorization flow (requires *Use OAuth2 Server*).
- `/oauth2/token` — exchange a code or credentials for tokens.
- `/oauth2/UserInfo` — fetch user claims.
- `/oauth2/revoke` — revoke a token.
- `/oauth2/certificates` and `/oauth2/jwk` — public keys for verifying tokens
  (these are intentionally public and expose only the public key).

> **Fork caveat:** because `msso` is a modified copy of OAuth2 Server, review its
> custom endpoints and behavior against your security requirements before exposing
> it. When in doubt, prefer the canonical OAuth2 Server module.
