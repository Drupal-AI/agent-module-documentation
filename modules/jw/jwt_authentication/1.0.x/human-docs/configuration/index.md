# Configuration

Setting up JWT Authentication is a five‑step sequence: create a signing key,
configure the module, assign permissions, test the token flow, then protect your
routes.

## 1. Create a signing key

The signing key is the heart of the system — a token is trusted only because it
verifies against this key.

1. Go to **Configuration → Security → Keys**
   (`/admin/config/system/keys`) and click **Add key**.
2. Choose a key type appropriate to the algorithm you'll use — a **JWT RSA Key**
   (RS256, 2048‑bit minimum) for asymmetric signing, or a **JWT HMAC Key**
   (HS256 / HS384 / HS512) for symmetric signing.
3. For the key **provider**, prefer one backed by an **environment variable** or a
   file outside the web root, so the raw key never lives in exported configuration
   or in code. (Raw key strings are supported for development, but avoid them in
   production.)
4. Save the key.

> **Why this matters:** anyone who obtains the signing key can forge a valid token
> for *any* user. Keep it secret, rotate it through the Key module, and prefer an
> asymmetric algorithm (RS256) so only the private key can sign.

## 2. Configure the module

1. Go to **Configuration → System → JWT Authentication**
   (`/admin/config/system/jwt-authentication`).
2. Set:
   - **Algorithm** — HMAC (HS256/384/512), RSA (RS256/384/512), or ECDSA
     (ES256/384/512). The algorithm and key are swappable without touching code.
   - **Key** — the signing key you created above.
   - **Access token TTL** — keep this **short** (minutes to an hour); clients
     refresh to get new ones.
   - **Refresh token TTL** — longer‑lived; controls how long a client can go
     without re‑entering credentials.
   - **Audience (`aud`) claim** — optional; set it if your consumers expect a
     specific audience value.
3. Save.

## 3. Assign permissions

On **People → Permissions** (`/admin/people/permissions`):

- **access jwt authentication** — grant to roles that should be able to obtain and
  refresh tokens. This is typically *Authenticated user*, and for a public API also
  *Anonymous* (so unauthenticated clients can log in to get their first token).
- **use jwt authentication** — grant to roles that need to call the **logout**
  endpoint.
- **administer jwt authentication** — keep restricted to administrators.

## 4. Test the token flow

Send a login request:

```bash
curl -X POST https://example.com/jwt-authentication/api/auth/tokens \
  -H 'Content-Type: application/json' \
  -d '{"username": "…", "password": "…"}'
```

A success returns `{"token": "…", "refresh_token": "…"}`. The other endpoints are
`POST /jwt-authentication/api/auth/refresh` (exchange a refresh token for a new
pair) and `POST /jwt-authentication/api/auth/logout` (revoke — this blacklists the
token's `jti` so it stops working immediately, even before it expires).

Note the built‑in protections you don't have to configure: per‑IP flood limits
(50 attempts/hour), per‑username limits (5 attempts / 5 minutes) that clear on a
successful login, and a timing‑safe guard so a wrong username can't be distinguished
from a wrong password by response time.

## 5. Protect your routes

On any route that should require a valid token, add the JWT provider under
`options` in your routing YAML:

```yaml
options:
  _auth: [jwt_authentication]
```

The authentication provider (priority 100) validates the Bearer token from the
`Authorization` header on every request to that route.

> **Serve everything over HTTPS.** Tokens are bearer credentials — anyone who
> captures one can use it until it expires or is revoked, so TLS is not optional.
