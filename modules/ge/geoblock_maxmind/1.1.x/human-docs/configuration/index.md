# Configuration

Configuring this module is really two things: **giving it a MaxMind database** to
read, and **pointing Geoblock at the MaxMind data source** so the data is actually
used. There is exactly one setting on this module's own form — the Download URL.

## Getting the MaxMind database in place

The module reads a MaxMind database file from **`private://geoblock_maxmind.mmdb`**.
You can provide it in either of two ways.

### Option A — maintain the file manually

Download a MaxMind GeoLite2/GeoIP2 Country database (a `.mmdb` file) under your
MaxMind licence, and place it at `private://geoblock_maxmind.mmdb` (that is,
`<your private files dir>/geoblock_maxmind.mmdb`). When you want to refresh it,
replace the file. Leave the Download URL blank in this mode. If the file is missing
or unreadable, lookups simply return nothing (no error) — and Geoblock then has no
country for that visitor.

### Option B — automatic download and weekly refresh

Set a **Download URL** on the settings form (below) that points at a `*.tar.gz`
archive containing a `.mmdb` file. On save, the module downloads the archive,
extracts the first `.mmdb` entry, and writes it to
`private://geoblock_maxmind.mmdb`. From then on, cron re-downloads it roughly once a
week to keep the data current.

## The Download URL setting

1. Go to **Configuration → Geoblock → MaxMind settings**
   (`/admin/config/geoblock/maxmind`). This requires Geoblock's **Administer
   geoblock** permission.
2. **Download URL** — enter the URL of a `.tar.gz` archive containing the MaxMind
   database (for example a MaxMind permalink, or a self-hosted mirror). Leave it
   **blank** if you are managing the `.mmdb` file yourself (Option A).
3. **Save.** When the URL is non-empty, saving immediately attempts the download to
   validate it; if the download fails, the field shows an error and the reason is
   logged to the `geoblock_maxmind` log channel. A successful save also schedules
   the next automatic update.

This is the module's only setting; it is stored as `download_url` in the
`geoblock_maxmind.settings` config object (empty by default) and is exportable like
any configuration.

> **Handle the URL as a secret.** MaxMind download permalinks embed your MaxMind
> **licence key** in the URL. Treat it as sensitive: avoid committing a real
> download URL into version-controlled config, and prefer keeping the licence key in
> an environment variable and constructing the URL from it rather than pasting a
> long-lived secret into exported config. Per this project's conventions, store
> secrets in an environment variable (via `ddev dotenv set .ddev/.env …`) rather
> than hard-coding them.

## Point Geoblock at the MaxMind data source

Supplying the database is only half the job — Geoblock still has to be told to use
it. In **Geoblock's own configuration**, select the **"MaxMind database file"**
data source. The allow/deny country rules themselves are Geoblock's, not this
module's.

## The automatic-update schedule

The next-update time is tracked in Drupal's State system under the key
`geoblock_maxmind.update_date` (a Unix timestamp). Cron only downloads when both a
valid Download URL is set and the current time has passed that timestamp; after each
attempt it reschedules about a week ahead. With no Download URL, cron does nothing.

## Scripting the setting (optional)

```bash
# read the current value
drush cget geoblock_maxmind.settings download_url

# set a download URL
drush php:eval '\Drupal::configFactory()->getEditable("geoblock_maxmind.settings")
  ->set("download_url", "https://example.org/GeoLite2-Country.tar.gz")->save();'

# disable auto-download (revert to manual file management)
drush php:eval '\Drupal::configFactory()->getEditable("geoblock_maxmind.settings")
  ->set("download_url", "")->save();'
```

Note that setting the value this way does **not** trigger a download — only saving
the settings form or a cron run does. To force a fetch, save the form.
