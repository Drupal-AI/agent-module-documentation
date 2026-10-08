# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Development → Site Guardian**, or navigate directly to
   `/admin/config/development/site_guardian`.

## Settings, field by field

- **Site Guardian key** — the access key that must be supplied (as
  `?site_guardian_key=…`) to reach the JSON endpoints. It is generated
  automatically on install and cannot be left blank. A **Generate new key** button
  rotates it — do this to revoke access for anyone holding the old key (remember to
  update your monitoring tools afterwards). Treat the key like a password.
- **Activated** — the master switch. When on (the default), the endpoints respond
  to valid requests. When off, both endpoints return *403 Forbidden* regardless of
  the key — a clean way to pause monitoring without uninstalling the module.
- **Notes** — free-text notes about this site (for example, applied patches or
  special considerations). They're exposed to consumers in the JSON and also shown
  as an *info* line on the local **Status report**.

Click **Save configuration** to apply.

## The endpoints page

At **Configuration → Development → Site Guardian → Endpoints**
(`/admin/config/development/site_guardian/endpoints`) you get a list of the
available endpoints with the current key already filled into the URLs, ready to
copy into your monitoring tool.

The two endpoints are:

- **`GET /site_guardian/status_report?site_guardian_key=<key>`** — the Status
  report data (Drupal / PHP / database versions, cron, warnings), plus anything
  other modules add via `hook_site_guardian_status()`.
- **`GET /site_guardian/enabled_modules_and_updates?site_guardian_key=<key>`** —
  every enabled project (core, contrib, custom) with its version and computed
  update/security status, equivalent to the Available updates report.

## How access works (the security model)

There is intentionally **no login** on the endpoints — the random key is the
credential. When a request arrives:

1. The module must be **activated**; if not, the request is forbidden.
2. The supplied key is compared to the stored key with a timing-safe comparison.
   A blank or wrong key is forbidden.
3. On failure, a **flood event** is registered. After **10 failed attempts per
   hour from one IP**, further attempts are blocked and the client IP is logged as
   a possible attacker. A successful request clears the counter.

Practical implications:

- **Always use HTTPS.** The key is in the query string; over plain HTTP it would
  be trivially sniffable.
- **Rotate the key** if you suspect it has leaked (Generate new key), and update
  your consumers.
- **Keep the key out of config exports** where possible — override it in
  `settings.php` from an environment variable, or use Config Ignore. This is a
  deployment choice, not a module flaw: by default the key is stored in config like
  any other value.

## Extending the status endpoint

Other modules can enrich the status report JSON by implementing
`hook_site_guardian_status()` — the returned array (same shape as a
`hook_requirements()` entry: title, value, severity, description) is merged into
the response. See the [`agent/` endpoints docs](../agent/api/endpoints.md) for a
code example.
