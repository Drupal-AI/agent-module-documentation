# REST Register User with Email Verification — manual setup guide

**REST Register User with Email Verification** (`rest_register_verify_email`) adds
REST endpoints for a register-then-verify signup flow, aimed at decoupled and app
front ends. A client POSTs registration data to create an account; the account is
created **blocked** so it cannot be used yet; a random verification token is emailed
to the user; the client then POSTs the username plus that token to a verify endpoint
to activate the account. There is also a resend-token endpoint for when the first
email is lost.

The flow is soundly built, and the public code review confirms the parts that matter:

- The account is explicitly **blocked on creation**, so it cannot be used until the
  email is verified.
- The registration field-set **only accepts custom `field_*` fields** (guarded by a
  `hasField()` check), so a caller cannot inject `roles`, `status` or `pass` to skip
  verification or escalate privileges.
- The verification token is generated with `Crypt::randomBytesBase64()` — a
  cryptographically random token of 80-plus bits — stored in tempstore and compared
  strictly, so it cannot realistically be guessed or brute-forced.
- CSRF header requirements are removed from these routes, which is expected for
  anonymous registration endpoints (there is no session yet).

This is the intended, verification-gated design. When adopting it, serve the
endpoints strictly over **HTTPS**, and keep your email channel trustworthy — the
emailed token is a bearer credential, so anyone who can read the email can activate
the account. Note the project is **not covered** by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   then activate the REST resources and open the registration/verify endpoints to
   anonymous callers.

There is **no dedicated settings form** for this module. Its endpoints are turned on
through core's REST configuration (most easily with the REST UI module), and the
token/email behaviour is configured as part of that REST resource and your site's
standard account email settings — all covered in the installation guide.

## Where it lives in the admin menu

The module adds no settings page of its own. You activate its REST resources at
**Configuration → Web services → REST** (`/admin/config/services/rest`, provided by
the REST UI module) and grant access at **People → Permissions**. The verification
email uses your site's normal account email settings under **Configuration → People →
Account settings**.
