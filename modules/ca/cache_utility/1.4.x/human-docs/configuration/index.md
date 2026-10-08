# Configuration

Cache Utility's endpoints are protected by a single shared secret — an **access
key**. Setting that key (and storing it safely) is the main thing to configure.

## Open the settings form

1. Log in as a user with the **Administer cache utility configuration** permission.
2. Go to **Configuration → Development → Cache Utility**, or navigate directly to
   `/admin/config/development/cache_utility`.

## Set the access key

The form has a field for the access key. Every cache-clear and status endpoint
requires this exact value in a `CU-ACCESS-KEY` request header; a request without it,
or with the wrong value, is refused. The form also shows example `curl` and Drush
commands, pre-filled with your key, that you can copy into a deploy script.

Choose the key carefully:

- **Make it long and random.** The endpoints have no rate limiting or lockout, so a
  weak key could in principle be guessed by an automated caller. A long random string
  removes that risk.
- **Avoid a purely numeric key** (like `1000` or a date such as `20250101`). Because
  of how the module compares the header, a numeric key can be matched by a different
  literal with the same numeric value — a real weakness. Use a mixed-character
  string instead.

## Store the key safely — it does not belong in exported config

The access key is saved inside the module's `cache_utility.settings` configuration.
That matters because on a site that manages configuration in Git (the normal Drupal
workflow), `drush cex` would write the live key into a YAML file and commit it — a
secret that authenticates cache-flush and OPcache-reset requests would end up in
version control and every clone.

To avoid that, do **one** of the following:

- Exclude `cache_utility.settings` from configuration export (using Config Ignore or
  Config Split), or
- Override the key in `settings.php` from an environment variable, so the committed
  config never holds the real value.

The default key is empty, and empty headers are rejected, so a site that hasn't been
configured yet is closed rather than exposed — the danger only appears once you set a
key and export config without excluding it.

## Other settings and notes

- The form offers a **`skip_ssl_verification`** option, but be aware it only changes
  the *example* `curl` command shown on the page (adding `--insecure`); it does not
  change any request the module itself makes. Leaving certificate verification on is
  the right choice.
- The settings page necessarily **shows the access key in cleartext** so the example
  commands can be copied. Anyone with the configuration permission — and anything
  that screenshots or caches that admin page — can therefore read it.
- Clearing OPcache via these endpoints resets it for the **entire PHP-FPM pool**, not
  just this Drupal site, so on shared hosting a valid key has a blast radius beyond
  your install.

## Save

Click **Save configuration**. Then test an endpoint (for example the Drupal cache
status route) with your key in the `CU-ACCESS-KEY` header to confirm it responds, and
wire the clear endpoints into your deployment pipeline.
