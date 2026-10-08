# How it works (plugin, downloader, cron)

Three moving parts: a Geoblock data-source plugin, a downloader service, and a cron hook.

## The data-source plugin

`src/Plugin/GeoblockDataSource/MaxMind.php` — a `@GeoblockDataSource(id="maxmind", label="MaxMind
database file")` plugin (the plugin **type** is defined by the parent `geoblock` module; this
module only provides an instance). On construction it opens `private://geoblock_maxmind.mmdb`
(the `geoblock_maxmind.database_path` parameter) with a `LibraryMarket\MaxMind\Database\Reader`
if the file exists; any error is swallowed (reader stays null).

Its `locate(IPAddress $address)` — called by Geoblock — for a **public** IP looks the address up
and sets `$address->setCountryCode(...)` and `setRegisteredCountryCode(...)` from the MaxMind
record's `country.iso_code` / `registered_country.iso_code`. If there is no reader (missing file)
it does nothing.

To use it, select the "MaxMind database file" data source in Geoblock's own configuration; the
allow/deny rules themselves are Geoblock's, not this module's.

## The Downloader service

`geoblock_maxmind.downloader` (`src/Downloader.php`), args
`['@plugin.manager.archiver', '@file_system', '%geoblock_maxmind.database_path%']`.
`download(string $url)`:

1. Streams the remote archive to a temp `*.tar.gz` (`fopen($url, 'r')` → `stream_copy_to_stream`).
2. Gets an archiver for it and scans its contents for the first entry matching `/.*\.mmdb$/i`
   (throws if none).
3. Extracts just that entry to a temp dir and `copy()`s it to `private://geoblock_maxmind.mmdb`
   (overwriting), then cleans up the temp dir.

## The cron hook

`geoblock_maxmind_cron()`:

- Reads `geoblock_maxmind.settings:download_url` (validated with `FILTER_VALIDATE_URL`) and the
  State `geoblock_maxmind.update_date`.
- Only when **both** a valid URL exists **and** now ≥ `update_date` does it: reschedule
  `update_date` to `strtotime('1 week')`, then call `downloader->download($url)`, logging success
  or error to the `geoblock_maxmind` channel.

So with no `download_url`, or with `update_date` in the future/unset, cron does nothing.

## Consequences an agent should know

- No `.mmdb` file ⇒ lookups silently return nothing; check `private://geoblock_maxmind.mmdb`
  exists and the private filesystem is configured.
- Country resolution accuracy and any private/reserved-IP handling come from the MaxMind reader;
  private IPs (`isPublic()` false) are skipped.
- This module contributes **data only** — to actually block by country you configure Geoblock.
- `FileSystem::prepareDirectory()` is called by the downloader with a variable (by-reference)
  when extracting, per Drupal's API.
