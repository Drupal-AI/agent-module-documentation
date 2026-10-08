# Configuration

Configuring JWT is two steps that must happen in order: **create a signing Key**, then **point
JWT at it**. Until you do both, the module has no key and cannot encode or decode tokens — in
fact the `jwt.config` object doesn't even exist on a freshly enabled site; it is created the
first time you save the JWT settings form.

## Step 1: Create a signing Key

JWT signs and verifies with a single site‑wide **Key** entity (from the Key module). Create one
at **Configuration → System → Keys** (`/admin/config/system/keys`) → **Add key**, and choose the
key type that matches the algorithm you want:

- **JWT HMAC Key** (`jwt_hs`) — a symmetric, shared‑secret key. Algorithms **HS256** (at least
  256‑bit), **HS384**, or **HS512**. The same secret both signs and verifies tokens. This is the
  simplest choice and a good default when the issuer and verifier are the same Drupal site.
- **JWT RSA Key** (`jwt_rs`) — an asymmetric key pair. Algorithm **RS256** (at least 2048‑bit).
  The **private** key signs (issues) tokens and the **public** key verifies them, so you can let
  other parties verify tokens without giving them the power to mint new ones. RSA requires PHP's
  OpenSSL extension.

When adding the key, set the **Key type** to one of the above and pick the **algorithm** in the
key type settings. For the key value, you can let the form **auto‑generate a strong value**, or
supply your own (a raw secret for HMAC, or a PEM private/public key for RSA). As always, prefer a
secure key provider (for example an environment variable via the Key module's env provider) over
storing the secret inline in configuration.

## Step 2: Point JWT at the Key

1. Go to **Configuration → System → JSON Web Token Authentication**
   (`/admin/config/system/jwt`). You need the **Administer JSON Web Token module** permission.
2. Select the key you just created from the **Key** dropdown — the list is filtered to `jwt_hs`
   and `jwt_rs` keys only, and the form rejects a key whose type doesn't match its algorithm.
3. Save the form. This creates the `jwt.config` object and stores the chosen key's id.

You can confirm it from Drush:

```bash
drush cget jwt.config key_id
```

## Permission

The module defines one permission, **Administer JSON Web Token module** (`administer jwt`). It is
a restricted (security‑sensitive) permission that gates the JWT admin pages, including this
settings form and the path‑auth form added by the JWT Path Auth submodule. Grant it only to
trusted administrators.

## Step 3: Wire tokens into authentication

The base module plus a key gives you signing, but you still need the submodules (see
[Installation](../installation/index.md)) to actually issue and accept tokens:

- Enable **JWT Authentication Consumer** so incoming tokens are validated and mapped to a Drupal
  user (it reads a `drupal.uid` / `drupal.uuid` / `drupal.name` claim from the token).
- Enable **JWT Authentication Issuer** to expose `/jwt/token`, which returns a signed token for
  the currently logged‑in user. (Use **JWT OAuth Client Credentials** instead for
  machine‑to‑machine issuance at `/oauth2/token`.)

Then, on each resource you want to protect — a REST resource, a Views REST export display, or a
JSON:API endpoint — enable **JWT authentication** (`jwt_auth`) as an accepted authentication
provider. Clients then send the token as `Authorization: Bearer <token>` (the module also accepts
a fallback `JWT-Authorization: Bearer <token>` header, useful on environments already protected by
HTTP basic auth).

## Rotating keys

Because JWT stores only the key id, rotating the signing key is simple: create a new Key entity
and repoint `jwt.config` at it (repeat steps 1–2). Any tokens signed with the old key immediately
stop validating, so key rotation doubles as a way to invalidate all previously issued tokens.

## Good to know

- **JWTs are signed but not encrypted.** Anyone holding a token can read its claims, so never put
  secrets in claims.
- **Caching:** the module includes a request policy that refuses to serve any request carrying a
  JWT from the anonymous page cache, so authenticated responses can't leak into it.
- **Debugging:** during development you can set `$settings['jwt.debug_log'] = TRUE;` in
  `settings.php` to log why a token failed to authenticate.
