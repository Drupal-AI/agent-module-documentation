# Configuration

File Gate is configured around two decisions: **how each file field is gated** (the
gate method and its limits) and **where the signing secret lives**. Both are
security-critical, so read this page before putting real content behind the gate.

## Store the signing secret securely

Every grant File Gate mints is HMAC-signed with a secret. **Anyone who obtains
that secret can mint valid download links for gated files**, so it must never
reach the browser and never sit in plain config that ends up in version control.

Keep it in an environment variable, a **Key** entity, or the module's secret
registry. On this project the recommended pattern is to store the value in an
environment variable (for example via DDEV's dotenv helper) and reference it
through a Key entity, so the raw secret never lives in the database or exported
config. The signing secret registry supports named secrets and dual-key rotation,
so you can rotate without invalidating everything at once.

## Choose a gate method per field

A **gate method** answers one question: has this request passed the gate for this
file? You configure the method on the file field. The core module ships several:

- **signed_url** — a short-lived, HMAC-signed URL. You set a per-field TTL, an
  absolute availability window, and usage limits (a one-time link is `max_uses =
  1`), all bound into the signature. Outstanding grants can be listed and revoked
  individually or in bulk.
- **authenticated** — deliver only to a logged-in Drupal user, with an optional
  role allowlist.
- **token** — a revocable per-grant token (revoke by deleting its stored hash, no
  secret rotation needed) and/or a pre-shared campaign-token allowlist for static
  links, with optional per-token TTL and max uses.
- **referrer_lock** — a signed URL that is additionally only redeemable from an
  allowed origin/referrer. Treat this as **defence in depth, not authorization** —
  the referrer header is spoofable.
- **otp** — a single-use one-time passcode e-mailed to a self-identified address,
  TTL-limited and attempt-locked. Prefer the OTP *session* endpoint so redemption
  uses an HttpOnly cookie rather than putting secrets in the query string.

The optional submodules add **form**, **commerce**, and **assurance** methods (see
[Installation](../installation/index.md)).

## Set sensible TTLs and limits

Short time-to-live values are your main safety margin: a leaked link stops working
quickly. Combine a short TTL with usage limits (one-time links where appropriate)
and an absolute availability window. For the token method, remember that revoking
is as simple as deleting the stored hash.

## Security essentials checklist

- Keep gated files on the **`private://`** scheme — public files bypass all
  gating.
- **Store the signing secret securely** — a leak lets anyone mint valid links.
- Use **short TTLs** and usage limits.
- Always serve over **HTTPS**.
- Grant the **bypass permission** only to trusted administrative roles — it lets
  an account retrieve gated files through `/system/files` directly.
- Treat `referrer_lock` as hardening, never as the sole gate.
