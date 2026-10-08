# Configuration

Configuring HeCAPTe is two steps: connect Drupal to your HeCAPTe server, then
choose which forms it protects. You'll need a running HeCAPTe server with a site
created and its **Site Key** to hand (see [Installation](../installation/index.md)).

## Connect Drupal to your HeCAPTe server

1. Log in as an administrator and go to **Configuration → People → CAPTCHA →
   HeCAPTe** (`/admin/config/people/captcha/hecapte`).
2. Enter your **HeCAPTe server URL** — use `https://` so the browser's calls to
   the challenge and Drupal's server-side `/verify` call are encrypted, and point
   it at a server you trust.
3. Enter your **Site Key** (copied from the HeCAPTe admin panel).
4. Save.

The module proxies the HeCAPTe runtime assets (`worker.js`, `wasm_exec.js`,
`solver.wasm`) through Drupal's own routes, so the visitor's browser never makes
cross-origin requests to your HeCAPTe server. Make sure the site key's **allowed
origins** in the HeCAPTe admin panel include your Drupal site's origin, or the
challenge will be rejected.

## Handle the site key safely

The site key is a credential — treat it with care. Don't paste it into anything
that gets committed to version control beyond the module's normal configuration
export, don't share it publicly, and rotate it in the HeCAPTe admin panel if you
suspect it has leaked. Where your workflow allows referencing an environment
variable instead of storing the value inline, prefer that; with DDEV you can keep
such values in `.ddev/.env` (which stays out of version control) via
`ddev dotenv set`.

## Protect specific forms

1. Go to the main CAPTCHA settings at **Configuration → People → CAPTCHA**
   (`/admin/config/people/captcha`).
2. For each form you want to protect (comment form, contact form, user
   registration, a Webform, and so on), set the challenge type to
   **hecapte_captcha / HeCAPTe**.
3. Save. Those forms now present the invisible HeCAPTe proof-of-work challenge,
   and submissions are verified server-side before they're accepted.

## Fail closed and set a sensible timeout

The security of this setup rests on the server-side `/verify` call, so make sure
it **fails closed**: if the HeCAPTe server is unreachable or returns an error, the
form submission must be *rejected*, never let through. Configure a sensible
**verify timeout** so a slow or down server doesn't hang your forms — but ensure a
timeout is treated as a failure, not a pass. Since Drupal only accepts a
submission when HeCAPTe responds with status `ok`, and the client can't fake that,
the challenge can't be bypassed from the browser — as long as verification
genuinely fails closed on errors.

## Test it

Open a protected form as an anonymous visitor. The challenge solves silently in
the background (no checkbox or puzzle), and a legitimate submission goes through.
To confirm the server-side check is active, you can temporarily point the server
URL at an unreachable host and verify that submissions are then *blocked* rather
than allowed.
