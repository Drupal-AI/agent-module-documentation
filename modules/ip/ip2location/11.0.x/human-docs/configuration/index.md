# Configuration

IP2Location has one settings form at **Configuration → System → IP2Location
Settings** (`/admin/config/system/ip2location`, route
`ip2location.admin_settings`). You need the *Administer site configuration*
permission to open it.

## The settings form, field by field

- **BIN database path** — the path to your IP2Location BIN file. The field help
  describes it as relative to the Drupal root, for example
  `sites/default/files/IP2Location-LITE-DB11.BIN`. When you save, the form
  validates the path (it checks the file exists) and performs a test lookup of
  `8.8.8.8` to confirm the database and library work together. If either check
  fails, fix the path or confirm the `ip2location/ip2location-php` library is
  installed.

- **Cache mode** — how the underlying library caches database reads, one of:
  - **No cache** — reads from disk each time. Lowest memory use, slowest lookups.
  - **Memory cache** — loads the database into PHP memory for faster lookups, at
    the cost of RAM per process.
  - **Shared memory** — uses shared memory for the fastest lookups on
    high‑traffic servers with enough RAM available.

  Start with No cache; switch to Memory or Shared memory only if lookups become a
  bottleneck and you have RAM to spare.

Click **Save configuration**.

## Keeping the database current

IP2Location updates its databases regularly (commercial editions monthly).
Download the fresh BIN, replace the file, and re‑point the path if the filename
changed.

## Accuracy behind a proxy or CDN

The geolocation is derived from the client IP that Drupal computes for the
request. If your site sits behind a reverse proxy or CDN, configure Drupal's
**trusted proxy / trusted host** settings in `settings.php` so the real visitor
IP is used — otherwise every lookup may resolve to the proxy's location.

## A note on trust

The database path is only writable by administrators with *Administer site
configuration*, so it is not an attacker‑controlled input — treat that permission
as trusted. The module exposes no public lookup endpoint; results live only in
each visitor's own session.
