# Configuration

Cloudflare's settings live in a CTools **wizard**. This page walks through what each
part does. All values are stored in the `cloudflare.settings` config object.

## Open the settings wizard

1. Log in as a user with the **Administer Cloudflare** permission (see below).
2. Go to **Configuration → Web Services → Cloudflare**, or navigate directly to
   `/admin/config/services/cloudflare`.

## Authentication

You connect to the Cloudflare API in one of two ways, chosen by the
**authentication method** setting (`auth_using`):

- **API token** (`token`, the default and recommended) — you supply a single API
  token (`api_token`). It's sent to Cloudflare as an `Authorization: Bearer` header.
  Tokens are preferred because they're scoped to specific zones and permissions and
  can be revoked independently.
- **API key + email** (`key`, legacy) — you supply your global API key (`apikey`)
  and account email (`email`). These are sent as `X-Auth-Key` and `X-Auth-Email`
  headers. Use this only where a token isn't available.

Whichever you choose, **store the secret in an environment variable or Key entity**,
not in committed configuration. Once a credential check passes, the module records
that in `valid_credentials` so you can confirm the connection is good before
attempting anything else.

## Zones

The **zones** setting (`zones`) records which Cloudflare zone(s) this site uses,
keyed by zone id. Most sites use one zone, but multi-zone setups are supported. The
wizard lets you select from the zones your credentials can see. (Older single-zone
keys `zone_id` / `zone_name` are deprecated in 2.0 and removed in 3.0 — use `zones`
instead.)

## Client-IP restoration

Because Cloudflare proxies traffic, without this feature Drupal would see a
Cloudflare edge IP as every visitor's address. These settings fix that:

- **Enable client IP restoration** (`client_ip_restore_enabled`, default off) —
  when on, the module's HTTP middleware rewrites each request's client IP to the
  real visitor, read from Cloudflare's `CF-Connecting-IP` / `CF-Visitor` headers.
  Turn this on so logging, flood control, rate limiting, analytics, and geolocation
  all see the true visitor IP.
- **Validate remote address** (`remote_addr_validate`, default on) — when on, the
  middleware first checks that the incoming request IP is within Cloudflare's
  published edge ranges before trusting its headers, and logs a warning on a
  mismatch. This guards against spoofed `CF-Connecting-IP` headers from requests
  that didn't actually come through Cloudflare. Keep it on unless you have a
  specific reason not to.
- **Bypass host** (`bypass_host`, default empty) — the hostname of an origin that
  legitimately reaches your server directly, bypassing Cloudflare (for example a
  health-check endpoint). Naming it here stops the module from logging false
  "request bypassed Cloudflare" warnings for that host.

## Cache purging

Purging the Cloudflare cache (by tag, by URL, or the whole zone) is **not** part of
this base module. It lives in the **Cloudflare Purger** submodule
(`cloudflarepurger`), which plugs into the Purge module and is configured at
`/admin/config/services/cloudflare/purger` plus the Purge admin UI. That submodule's
settings form is protected by the same **Administer Cloudflare** permission.

## Permission

The module defines a single permission:

- **Administer Cloudflare** (`administer cloudflare`) — gates the settings wizard
  *and* the Cloudflare Purger settings form. It's marked security-sensitive because
  it exposes and changes your Cloudflare API credentials, so grant it only to
  trusted administrators. Assign it at **People → Permissions**
  (`/admin/people/permissions`).

There are no per-content permissions.

## Setting values from the command line

```bash
drush config:get cloudflare.settings
drush config:get cloudflare.settings client_ip_restore_enabled
```

Prefer the wizard for entering credentials so validation runs, but the config
object can also be set programmatically via the config factory if you're scripting
an environment.
