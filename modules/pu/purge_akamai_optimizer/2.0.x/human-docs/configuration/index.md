# Configuration

Purge Akamai Optimizer's own settings live at **Configuration → Akamai → Purge
Akamai Optimizer settings**
(`/admin/config/akamai/purge-akamai-optimizer-settings`), gated by the
**Administer Akamai** permission. This form is the module's only surface — but
remember that the *base* purge behavior and, crucially, your **Akamai
credentials** are configured in the **Purge** and **Akamai** modules, not here.

## The optimizer settings

On this form you control how cache tags are optimized before they reach Akamai:

- **Tag prefix / identifier rules** — define the prefixes of cache tags that
  should be collapsed and replaced with a single identifier in the edge cache‑tag
  header. All tags matching a prefix are represented by that identifier, and the
  module sends the appropriate replacement tags at purge time. This is what keeps
  a page under Akamai's ~128‑tag limit.
- **Tag hashing** — the module hashes cache tags into short (5‑character)
  identifiers so the edge cache‑tag header stays within Akamai's 8192‑character
  limit.
- **Site / file identifiers** — a site identifier tag is added to every HTML page
  (and a file identifier for files), which is what powers the *Akamai purge
  everything* purger for whole‑cache invalidation.
- **Disable Akamai caching** — an option to turn Akamai caching off when you need
  to.

Save the form once you've set your prefixes and options. Cron then drives the
housekeeping — cleaning up old identifier records and generating the priority‑tag
list — so make sure cron runs regularly.

Refer to the module's own README for the finer details of each field, and to the
Purge and Akamai documentation for how the pieces fit together.

## Where the Akamai credentials go (and how to store them safely)

This module does **not** make any calls to Akamai itself and does **not** store
Akamai credentials — all of that belongs to the **Akamai** module. Configure your
Akamai API credentials (the EdgeGrid client token, client secret, and access
token) there.

Those credentials are **secrets**, so don't hard‑code or commit them:

1. **Store the values in environment variables**, not in exported configuration.
   With DDEV, set them via the built‑in dotenv command, for example:

   ```bash
   ddev dotenv set .ddev/.env --akamai-client-secret=<value>
   ddev restart
   ```

   The flag `--akamai-client-secret` becomes the variable
   `AKAMAI_CLIENT_SECRET` inside the container. Keep `.ddev/.env` out of version
   control.

2. **Reference the secret through a Key entity** where the Akamai module supports
   one. Install the **Key** module if it isn't already
   (`ddev composer require drupal/key && ddev drush en key -y`), confirm the
   variable is present in the container *without printing its value*
   (`ddev exec 'test -n "$AKAMAI_CLIENT_SECRET"'` — exit status 0 means it's
   set), then create a Key that reads it from the environment provider and point
   the Akamai module's credential setting at that Key. Where a Key entity doesn't
   apply, read the variable in `settings.php` via `getenv()`.

## A note on network egress

Because the whole point of this stack is to invalidate Akamai's CDN cache, the
Akamai module makes **outbound HTTPS requests to Akamai's API** (the
`*.akamaiapis.net` EdgeGrid endpoints). Make sure your hosting environment allows
that outbound egress; if your servers sit behind a strict firewall or proxy,
whitelist the Akamai API hosts so purges can actually be sent.
