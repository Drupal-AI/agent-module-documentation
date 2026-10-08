# Configuration

Configuring Iplicit API is a two-part job: first store the **API key as a secret**
using the Key module, then point the connection settings at your Iplicit domain and
press **Test connection**.

## Step 1 — Store the API key securely

The whole point of the Key integration is that the secret never lands in the
database or in `config/sync`. The recommended approach is an **environment
variable** the container provides.

If you run **DDEV**, save the value into DDEV's dotenv file (it is not committed)
and restart so the container picks it up:

```bash
ddev dotenv set .ddev/.env --iplicit-api-key=<your-api-key>
ddev restart
```

That makes the variable `IPLICIT_API_KEY` available inside the web container.
Confirm it is present **without printing its value**:

```bash
ddev exec 'test -n "$IPLICIT_API_KEY"'   # exit status 0 means it is set
```

Then create a **Key** entity that reads from that variable. Either use the UI at
**Configuration → System → Keys → Add key** (choose the *Environment* key
provider and point it at `IPLICIT_API_KEY`), or Drush:

```bash
ddev drush key:save iplicit_api_key --label='Iplicit API Key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"IPLICIT_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

The **File** provider is an equally good choice if you prefer a file on disk. Avoid
the "Configuration" provider, which would store the secret in the database.

## Step 2 — Fill in the connection settings

Go to **Configuration → Web services → Iplicit API**
(`/admin/config/services/iplicit`). You need the **Administer Iplicit API**
permission, which is restricted — grant it only to trusted administrators. The form
stores its values in `iplicit_api.settings`; the fields are:

- **Base URI** — the root URL of the Iplicit API you are calling.
- **Domain** — your Iplicit domain (for example `sandbox.demo` for a sandbox, or
  something like `live.acme` for production). Iplicit requires this on every
  request as a `Domain` header, and the client adds it for you.
- **Username** — the Iplicit API username paired with your key.
- **API key** — select the **Key** entity you created in Step 1. Only the key's
  *ID* is stored here, never the secret itself.
- **Timeout** — how long (in seconds) to wait for Iplicit before giving up.
  Default is **30**.
- **Enabled** — the master on/off switch. When unticked, the client refuses every
  request, which is a safe way to disable the integration without deleting your
  settings.
- **Debug** — turns on extra logging to the `iplicit_api` channel. The debug log
  records only metadata (domain, API version, token expiry) — the session token,
  API key, and Authorization header are never logged.

## Step 3 — Test the connection

Press **Save and test connection**. On success it reports the domain, the Iplicit
API version, and when the current session token expires. If anything required is
missing or wrong, the client reports a configuration or authentication error rather
than failing silently.

## Per-environment overrides

Because the domain often differs between sandbox and production, you can override
any setting per environment in `settings.php` without touching exported config:

```php
$config['iplicit_api.settings']['domain'] = 'live.acme';
```

## A note on egress and secrets

This module makes **outbound HTTPS calls to Iplicit's servers**, sending your
credentials and accounting data. The client uses Drupal core's HTTP client factory
with **normal TLS certificate verification** — it does not disable certificate
checks. Keep the API key in an environment variable or file (as above) rather than
in the database. One operational caveat: while a session token is cached, a
database dump taken in that window contains a usable bearer token, which is another
reason to prefer the env/file Key providers and to rotate credentials if a dump
leaks.
