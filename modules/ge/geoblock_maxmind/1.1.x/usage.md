MaxMind Data Source plugs a MaxMind GeoIP database (a `.mmdb` file) into the Geoblock module as a country-lookup data source, so Geoblock can resolve a visitor's country from their IP using MaxMind data.

---

The module extends [Geoblock](https://www.drupal.org/project/geoblock) with a
`GeoblockDataSource` plugin (id `maxmind`) that reads a local MaxMind database file to map an IP
address to its ISO country code (and registered-country code). The database file is expected at
`private://geoblock_maxmind.mmdb` (the `geoblock_maxmind.database_path` service parameter);
lookups use the `librarymarket/maxmind-db-reader` PHP library. You can either place/update that
`.mmdb` file manually, or configure a **Download URL** on the module's settings form
(`/admin/config/geoblock/maxmind`, permission `administer geoblock`) pointing at a `*.tar.gz`
archive containing a `.mmdb`. When a Download URL is set, the module's `Downloader` service
fetches and extracts the archive (validated once when you save the form), and `hook_cron()`
re-downloads it roughly weekly, tracked by the State value `geoblock_maxmind.update_date`. The
only config is `geoblock_maxmind.settings.download_url` (empty string by default). With no URL,
auto-download is disabled and you maintain the `.mmdb` yourself in accordance with your MaxMind
license. Actual blocking rules (which countries to allow/deny) live in the parent Geoblock
module — this submodule only supplies the country data.

---

- Give Geoblock a MaxMind-backed country lookup for geographic access control.
- Resolve a visitor's country from their IP using a local GeoLite2/GeoIP2 `.mmdb` file.
- Serve country lookups fully offline once the database file is in place (no per-request API call).
- Configure an automatic weekly refresh of the MaxMind database via a Download URL.
- Point the Download URL at a self-hosted `*.tar.gz` mirror of the MaxMind database.
- Keep the MaxMind database in the private filesystem (`private://geoblock_maxmind.mmdb`).
- Update the database manually by replacing the `.mmdb` file when you prefer no auto-download.
- Disable auto-download by clearing the Download URL (leaving the file under manual control).
- Let cron keep the GeoIP data current without manual intervention.
- Validate a Download URL up front (the settings form attempts a download when you save).
- Feed both country and registered-country codes into Geoblock's IP resolution.
- Comply with MaxMind licensing by pulling updates from your own permitted endpoint.
- Restrict content or access by country using MaxMind accuracy rather than a coarser source.
- Swap Geoblock's data source to MaxMind on sites that already license MaxMind data.
- Schedule the next database update at least a week out (tracked in State).
- Provide geolocation data for other Geoblock-driven rules on the site.
- Store the download endpoint as exportable config (`geoblock_maxmind.settings:download_url`).
- Log update successes/failures to the `geoblock_maxmind` logger channel.
- Recover gracefully when the database file is missing (lookups simply return nothing).
- Use MaxMind data for country detection while keeping blocking logic in Geoblock.
- Extract only the `.mmdb` entry from a downloaded archive automatically.
