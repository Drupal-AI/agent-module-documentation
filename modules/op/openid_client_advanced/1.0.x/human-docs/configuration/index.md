# Configuration

OpenID Client Advanced is configured as a client of the **OpenID Connect** module.
You add a client, choose the advanced plugin, point it at your provider, and turn
on the security features.

## Handle the client secret as a secret

The module deliberately supports keeping the secret out of configuration — use it.
Serve your site over HTTPS, and prefer the **Environment Variable** or **File in
Secrets Directory** secret source over plain text. With DDEV you might store the
value in the environment and never commit `.ddev/.env`:

```bash
ddev dotenv set .ddev/.env --oidc-client-secret=<your-secret>
ddev restart
```

then choose **Environment Variable** as the secret source and enter the variable
name.

## Add and configure the client

Go to **Configuration → People → OpenID Connect**
(`/admin/config/people/openid-connect`), add or edit a client, and choose **OAuth
2.0 Advanced**:

- **Client ID** — the ID issued by your provider.
- **Client Secret Source** — pick one:
  - **Plain Text** — the secret typed directly (least preferred).
  - **Environment Variable** — the name of the env var holding the secret.
  - **File in Secrets Directory** — the filename (basename only) in your configured
    secrets directory.
- **Endpoints** — either tick **Auto discover endpoints** and provide an **Issuer
  URL** (the module pulls the endpoints from
  `/.well-known/openid-configuration`), or leave it unticked and enter the
  **Authorization**, **Token**, **UserInfo**, and **End Session** endpoints
  yourself.
- **Scopes** — space‑separated, e.g. `openid email`.

## Turn on the security features

These are what make the module worth using — enable the ones your provider
supports:

- **Use PKCE (S256)** — sends a `code_challenge` (method `S256`) during
  authorization and a `code_verifier` at token exchange. If PKCE is on but the
  verifier isn't available in the session at callback time, login is rejected and
  a trace ID is logged and shown.
- **Validate ID token signature** — turn on verification and provide the
  provider's **RSA/ECDSA public keys as PEM** (blank‑line separated) or a **JWKS
  JSON** document. Optionally restrict **Allowed signature algorithms** (e.g.
  `RS256 RS512`). Failures are logged to `openid_connect_advanced`.
- **Send nonce parameter** — includes a nonce in the authorization request; it's
  stored in the session and must match the `nonce` claim in the returned ID token,
  or the login is rejected and logged. Enable this for replay protection.

Save the client.

## Security posture — what's handled where

- **Login CSRF (the OAuth `state` parameter):** handled by the OpenID Connect base
  module's state‑token service — this module doesn't reimplement it. Keep OpenID
  Connect updated.
- **Token authenticity (signature), replay protection (nonce), and code
  interception (PKCE):** added by this module, once you enable them above.

## Test it

Attempt a login through the advanced client. On success the user is logged in; on
any verification failure the login is rejected and the user is shown a **trace
ID** you can match against the log entry to see what failed (signature, nonce, or
PKCE verifier).
