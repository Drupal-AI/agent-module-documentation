# Configuration

KeyCDN is configured through the **Purge** module, not a page of its own. The
`Cache-Tag` header side of the integration works automatically once the module is
enabled — the only thing to set up is the purger.

## Add the KeyCDN purger

1. Log in as an administrator and go to **Configuration → Development → Performance →
   Purge** (`/admin/config/development/performance/purge`).
2. In the **Purgers** section, add a new purger and choose the one provided by this
   module (the **KeyCDN** purger).
3. Open the purger's settings to configure it.

## Enter your KeyCDN credentials

The purger needs two values from your KeyCDN account:

- **API key** — your KeyCDN API key, used to authenticate purge requests. This is
  the sensitive credential (see below).
- **Region / zone name** — the KeyCDN zone the purger should invalidate.

Both are available from your KeyCDN dashboard at
[keycdn.com](https://www.keycdn.com/). Save the purger settings.

With the purger in place, Purge sends tag‑based invalidations to KeyCDN whenever
your content changes, so the CDN's edge cache stays in sync with the site.

## Keep the API key secure

- **Don't commit the key.** Prefer supplying it from an **environment variable**
  rather than typing a permanent secret into exported configuration. With DDEV you
  can store it with `ddev dotenv set .ddev/.env --keycdn-api-key=<value>` (never
  commit `.ddev/.env`) and reference it from `settings.php`.
- Anyone who can export your site configuration can read a key stored directly in
  config, so treat configuration exports as sensitive.
