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
environment variable (for example via DDEV's dotenv helper) and reference it from
`settings.php`, so the raw secret never lives in the database or exported config:

```php
// settings.php — never exported.
$config['file_gate.settings']['download_secret'] = getenv('DRUPAL_FILE_GATE_SECRET');
```

The signing secret registry supports **named secrets** (scoped to specific fields)
and **dual-key rotation**, so you can rotate without invalidating every outstanding
grant at once. Named-secret values live in `$settings['file_gate.secrets']`; their
field scopes are exportable config under `secret_scopes`.

## Choose a gate method per field

A **gate method** answers one question: has this request passed the gate for this
file? You configure the method on the file field (edit the field, open the **File
Gate** section, tick **"Gate access to these files"**, then pick a method).
Enabling gating forces and locks the field's storage to the **private** file
system. The core module ships several methods:

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

### Require an acting account (optional)

You can require every mint to name an acting account — globally with
`require_acting_account`, or per field with the **require identity mint** checkbox
on the field's gate-method settings. When set, File Gate refuses a mint that has no
`account`/`uid`, and narrows the grant to what that account may actually reach. As
of 1.8.0 the `signed_url` and `token` methods expose this checkbox and preserve it
across a field-settings save (previously only the assurance method did).

## Set sensible TTLs and limits

Short time-to-live values are your main safety margin: a leaked link stops working
quickly. Combine a short TTL with usage limits (one-time links where appropriate)
and an absolute availability window. For the token method, remember that revoking
is as simple as deleting the stored hash.

Global defaults (default TTL, content disposition, and the mint / download flood
limits) live at **Administration → Configuration → Media → File Gate**
(`/admin/config/media/file-gate`), which also shows the secret status and every
gated field.

## Security essentials checklist

- Keep gated files on the **`private://`** scheme — public files bypass all
  gating.
- **Store the signing secret securely** — a leak lets anyone mint valid links.
- Use **short TTLs** and usage limits.
- Always serve over **HTTPS**.
- Grant the **bypass permission** only to trusted administrative roles — it lets
  an account retrieve gated files through `/system/files` directly.
- Treat `referrer_lock` as hardening, never as the sole gate.
