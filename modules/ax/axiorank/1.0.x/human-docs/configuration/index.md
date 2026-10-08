# Configuration

## Open the settings form

1. Log in as a user with the **`administer axiorank`** permission.
2. Go to **Configuration → Web services → AxioRank**
   (`/admin/config/services/axiorank`).

## Settings

- **Site key** — your AxioRank site key, used to authenticate the module's calls to
  the verify service. For good secret hygiene, the module reads the site key from
  `settings.php` first, and only then from stored config — so you can keep the key
  out of exported configuration by defining it in `settings.php` (ideally from an
  environment variable via `getenv()`).
- **Base URL** — the AxioRank service base URL the module posts to.
- **Posture** — choose **monitor** (record verdicts only, block nothing) or
  **enforce** (act on verdicts). Start in monitor mode and watch the recorded
  activity before switching to enforce.
- **Scopes** — which route types to verify (for example HTML pages, core REST,
  JSON:API), so you can limit checking to the endpoints you care about.

## Test the connection

Use the **Test connection** action (a CSRF‑protected route at
`/admin/config/services/axiorank/test`) to confirm your site key and base URL are
valid before relying on the module.

## How enforcement actually behaves

- Verification runs on incoming main requests through a request subscriber, with a
  short **1‑second timeout** so it does not add noticeable latency.
- Blocking only happens when **both** your posture is `enforce` **and** the
  AxioRank server marks the verdict as one to enforce — returning a **403** for a
  block verdict or **401** for a challenge.
- **Fail‑open by design:** any timeout, network error, non‑2xx response, malformed
  response, or even a rejected site key (401) results in the request being
  **allowed through**. A bad site key is surfaced as a warning to administrators but
  still fails open, so a problem with AxioRank never takes your site down.
- Your visitors' **cookie and authorization headers are never forwarded** to the
  AxioRank service.
