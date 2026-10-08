# Configuration

Advanced CORS is configured as a list of **CORS policies** (each one a `route_config`
config entity). You manage them at **Configuration → Web services → CORS Settings**
(`/admin/config/services/advanced_cors`). Only users with the core **Administer
site configuration** permission can add, edit, or delete policies.

Until you create a policy, the module sends no headers at all.

## Add a policy

On the CORS Settings page, click to add a policy and fill in the fields below.
Each policy has a human‑readable **label** and a machine **id**, and can be
enabled or disabled (only enabled policies are considered).

## The fields

| Field | Header it sets | What it does |
|---|---|---|
| **Patterns** | — | One path pattern per line. Uses Drupal's path‑matcher syntax with `*` wildcards, matched against the internal (post‑alias) path — e.g. `/api/*`. A policy applies when one of its patterns matches the request. |
| **Weight** | — | Sort order. Lower weight is checked first, and the **first** matching policy wins, so give more specific policies a lower weight. |
| **Allowed origins** | `Access-Control-Allow-Origin` | One origin per line (e.g. `https://app.example.com`). See origin handling below. |
| **Allowed methods** | `Access-Control-Allow-Methods` | e.g. `GET, POST, OPTIONS`. |
| **Allowed headers** | `Access-Control-Allow-Headers` | Request headers the browser may send, e.g. `Content-Type, Authorization`. |
| **Exposed headers** | `Access-Control-Expose-Headers` | Response headers the browser is allowed to read. |
| **Max age** | `Access-Control-Max-Age` | How long (in seconds) the browser may cache a preflight result. |
| **Supports credentials** | `Access-Control-Allow-Credentials` | Set to allow credentialed (cookie/auth) cross‑origin requests. |

Each header (other than origin) is only sent when its value is non‑empty; blank
fields are skipped. Patterns and allowed origins are split on newlines and
trimmed.

## How a request is matched

1. On every response, the module takes the request path and resolves it to the
   internal path via the alias manager.
2. It walks the enabled policies in weight order and, on the **first** pattern
   that matches, applies that policy's headers and stops.

So exactly **one** policy applies per request. If two policies could match the
same path, the one with the lower weight wins — order them accordingly.

## How the allowed origin is chosen

The `Access-Control-Allow-Origin` header can only carry a single value, so the
module picks one:

- If the request's `Origin` header **exactly matches** one of the policy's
  **Allowed origins**, that origin is echoed back.
- Otherwise it returns the **first** configured origin. Since that won't match the
  requester, the browser blocks the response — a deliberate signal that the origin
  isn't allowed.

The value returned always comes from your configured list; the module never
reflects an arbitrary, unlisted origin.

## Caching

The enabled patterns are cached. After you add, edit, disable, or delete a policy,
rebuild caches so the change takes effect:

```bash
ddev drush cr
```

## Security caveat — read before you save

The values you enter are written to the response headers verbatim, and the module
does **not** stop you from configuring an unsafe combination. The classic mistake
is setting **Allowed origins** to `*` together with **Supports credentials**
enabled — the spec‑violating "wildcard + credentials" case that browsers reject,
and which, if a single explicit origin were used instead, would permit
credentialed cross‑origin reads of your data.

To stay safe:

- List **explicit, trusted origins** rather than `*` whenever the endpoint returns
  anything non‑public.
- Only enable **Supports credentials** when you genuinely intend credentialed CORS,
  and only alongside an explicit origin list.
- Scope permissive policies to the narrowest path patterns that need them.

This is a trusted‑admin configuration choice (the page is behind *Administer site
configuration*), not an unauthenticated exposure — but a wrong choice still has
real security consequences, so configure it deliberately.
