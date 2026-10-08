# Configuration

Open the form at **Configuration → Web services → CORS** (`/admin/config/services/cors`), which
requires the *administer cors* permission (*restrict access*). It saves to the
`cors_ui.configuration` config object and, on save, rebuilds the container so the new policy takes
effect right away.

## Fields

| Field | Type | What it controls |
|---|---|---|
| **Enabled** | checkbox | Master on/off for core's CORS middleware. |
| **Allowed origins** | textarea, one per line | The origins allowed to make cross-origin requests. Enter `*` on its own to allow all. |
| **Allowed methods** | textarea, one per line | HTTP methods permitted cross-origin (GET, POST, …), or `*`. |
| **Allowed headers** | textarea, one per line | Request headers browsers may send cross-origin, or `*`. |
| **Exposed headers** | textarea, one per line | Response headers made readable to cross-origin JavaScript, or `*`. |
| **Supports credentials** | checkbox | Whether credentialed (cookie/auth) cross-origin requests are allowed. |
| **Max age** | number | `Access-Control-Max-Age` — how long (seconds) browsers may cache the preflight response. |

The textareas accept one value per line and are converted to arrays for you.

## Origin validation

When you save, **Allowed origins** is validated (unless it is exactly `*`):

- `*` may **not** be combined with other origins — that is rejected.
- Each origin must be a valid **scheme + host + port only**. Any path, query, or fragment is
  rejected — `https://example.com` is fine, `https://example.com/app` is not.

## How it reaches core's middleware

Core's CORS middleware reads the container's `cors.config` parameter (normally set in
`sites/*/services.yml`). CORS UI overrides that parameter from your saved config via a service
provider and compiler pass. Because the parameter is baked into the compiled container, a change
requires a container rebuild — CORS UI does this automatically on save (it also invalidates the
response cache), and the form shows a message noting the rebuild. If you change the values with
Drush instead, run `drush cr` afterwards so the container picks them up:

```bash
drush cset cors_ui.configuration enabled true -y
drush cr
```

(The origins/methods/headers keys are sequences, so those are easiest to edit via the form or a
config import rather than a single `cset`.)

## Security implications — read before allowing broad access

CORS decides **which other websites' JavaScript may read responses from your site**. Getting it
wrong can expose data. Keep these in mind:

- **Prefer an explicit allow-list of trusted origins** over the `*` wildcard. Use `*` only for a
  genuinely public, read-only API.
- **Never combine `*` origins with Supports credentials.** Allowing credentialed requests from
  any origin would let any site make authenticated, cookie-bearing requests on a logged-in user's
  behalf and read the results. Enable credentials only alongside a specific, trusted origin list.
- Only expose the response headers a client actually needs, and keep allowed methods to the
  minimum your integration requires.

On the reassuring side: the form is gated by *administer cors* (*restrict access*), so there is no
non-admin path to change these values, and the module seeds its defaults from your existing
`services.yml` policy rather than shipping anything permissive. The risk is in the policy you
choose to save — so choose the narrowest one that works.
