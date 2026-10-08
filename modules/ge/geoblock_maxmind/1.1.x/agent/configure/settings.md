# Configure geoblock_maxmind

## The one setting

Config object **`geoblock_maxmind.settings`**, single key **`download_url`** (schema type `uri`,
default `''`):

- **Empty** (default) → auto-download is **off**. You must place/maintain the MaxMind database
  yourself at `private://geoblock_maxmind.mmdb`.
- **Set** to a permalink of a `*.tar.gz` archive that contains a `.mmdb` file → the module
  downloads and extracts it (on form save, and periodically via cron).

## Via the UI

1. Go to **Configuration → Geoblock → MaxMind settings** (`/admin/config/geoblock/maxmind`).
   Requires **`administer geoblock`** (Geoblock's permission; this module adds none).
2. Enter the **Download URL** (a `.tar.gz` archive URL). Leaving it blank means "I manage the
   `.mmdb` file manually."
3. **Save.** On save with a non-empty URL the form immediately attempts the download
   (`Downloader::download()`); if it fails the field errors and the reason is logged to the
   `geoblock_maxmind` channel. A successful save also seeds the next-update State.

## Via drush (scriptable)

```bash
# read
drush cget geoblock_maxmind.settings download_url

# set a download URL
drush php:eval '\Drupal::configFactory()->getEditable("geoblock_maxmind.settings")
  ->set("download_url", "https://example.org/GeoLite2-Country.tar.gz")->save();'

# disable auto-download (back to shipped default)
drush php:eval '\Drupal::configFactory()->getEditable("geoblock_maxmind.settings")
  ->set("download_url", "")->save();'
```

Note: setting `download_url` directly via drush/config does **not** trigger a download (only the
settings form's validate step and cron do). To actually fetch, either save the form or call the
downloader service.

## The database file

- Path: `private://geoblock_maxmind.mmdb` (from the `geoblock_maxmind.database_path` service
  parameter). Requires the private file system to be configured.
- If the file is absent or unreadable, the `maxmind` data-source plugin simply resolves nothing
  (no error) — Geoblock then has no country for that IP.

## Auto-update State

- **State key `geoblock_maxmind.update_date`** — a unix timestamp; cron only downloads when
  "now ≥ update_date". After each attempt the module reschedules it ~1 week ahead
  (`strtotime('1 week')`). Read/seed it with `\Drupal::state()->get/set('geoblock_maxmind.update_date')`.
- Do **not** stash baselines in State on this shared site; delete the key to reset
  (`\Drupal::state()->delete('geoblock_maxmind.update_date')`).
