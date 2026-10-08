# Configuration

OAuth 1.0 is a support/authentication module: the "configuration" is mostly about
who may register API consumers and setting up the consumer credentials that a
third‑party integration uses to sign its requests. Because registering a consumer
grants API access, the permissions here matter as much as any setting.

## Open the admin form

1. Log in as an administrator.
2. Go to the module's admin settings (route `oauth.admin_form`) to review its
   options.

## Permissions — assign deliberately

On **People → Permissions**, the module adds two permissions, both restricted:

- **access own consumers** — lets a user manage the OAuth consumers they own. Grant
  this to roles that legitimately need to create and manage their own API
  credentials.
- **oauth register any consumers** — lets a user register consumers broadly. This
  is a powerful grant of API access; keep it to trusted administrators only.

Both are marked as restricted for good reason: a consumer registration is
effectively handing out a key to your site's API on a user's behalf. Treat them
accordingly.

## Register a consumer

A consumer represents the third‑party application that will authenticate against
your API. When you register one, it is issued a **consumer key and secret**; the
consuming application uses that shared secret to **sign** each request. Provide
those credentials to the integration through a secure channel — never email them in
plain text or commit them to a repository — and store them as secrets on the
consumer's side.

## Operating OAuth 1.0a safely

If you are relying on OAuth 1.0a, the places the signing scheme goes wrong are worth
checking in whatever implementation is handling requests:

- **Signature comparison must be constant‑time** — to avoid timing attacks.
- **Nonces must be tracked** — so a signed request cannot be replayed within its
  timestamp window.
- **The timestamp window must be enforced and narrow** — a wide window turns nonce
  tracking into an unbounded store and widens the replay window.

Always run OAuth 1.0a over **HTTPS**.

## When to use something else

For any new integration, prefer **OAuth 2.0 with `simple_oauth`** rather than this
module — it is simpler to implement correctly and actively specified. Use OAuth
1.0a here only because a specific partner, enterprise, financial or government
system on the other end requires it.
