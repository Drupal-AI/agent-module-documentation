<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OAuth2 Client provides configurable OAuth2 client apps to call external OAuth2-protected APIs.

---

OAuth2 Client (oauth_client) **provides configurable OAuth2 client apps** — letting the site obtain OAuth2
tokens (currently focused on the **client_credentials** grant; the authorization_code grant is not yet enabled) to
call external OAuth2-protected APIs. It depends on core Options, User, Views and the Simple OAuth module, and
provides its own permissions.

Use it to authenticate the site to external OAuth2 APIs. It is an authentication/integration framework.
Security/data handling: it stores **OAuth2 client credentials (client id/secret) and obtained tokens** — store the
**client secret as a secret** (env/Key), protect stored tokens (treat as sensitive credentials), and serve token
requests over HTTPS. Since the interactive authorization_code login flow is disabled in this version, there is no
end-user login-CSRF surface here. It has its own permissions. Configure the OAuth2 client credentials.

---

- Provide OAuth2 client apps.
- Obtain tokens (client_credentials grant).
- Call external OAuth2 APIs.
- Depend on Options, User, Views, Simple OAuth.
- Provide its own permissions.
- Serve authentication/integration.
- Store client credentials + obtained tokens.
- Store the client secret as a secret (env/Key) + protect tokens.
- Serve token requests over HTTPS.
- Have no end-user login-CSRF surface (authorization_code disabled).
- Configure the client credentials.
- Handle OAuth2 client.
- Get tokens.
- Configure the client.
- Call APIs.
- Handle the integration.
- Authenticate to APIs.
- Manage clients.
- Secure the secret.
- Provide OAuth2 client apps.
