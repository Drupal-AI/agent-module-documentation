# Configuration

The settings form is at **Configuration → People → IP-based determination of
Country** (`/admin/config/people/ip2country`), and requires the **Administer
ip2country** permission. All values live in the `ip2country.settings` config object.

## Data source and updates

- **Registry** (`rir`, default `all`) — which Regional Internet Registry to pull
  allocation data from. Choose `all` (recommended, combines every registry),
  `arin`, `ripe`, `apnic`, `afrinic`, or `lacnic`. Pick a single registry if you
  only care about one region and want a smaller, faster import.
- **Update interval** (`update_interval`, default weekly / 604800 seconds) — how
  often cron refreshes the database. Options run from daily up to every four weeks,
  or **0 to turn automatic updates off** entirely (you then update manually or via
  Drush).
- **Batch size** (`batch_size`, default 200) — how many rows are inserted per batch
  during import. Lower it if the import runs short on memory; raise it to import
  faster on a capable server.
- **MD5 checksum** (`md5_checksum`, default off) — verify the downloaded file
  against an MD5 checksum when the registry provides one. RIRs don't always publish
  one, so this is off by default.
- **Watchdog logging** (`watchdog`, default on) — log each database update to
  Drupal's log (dblog/watchdog) for auditing.

## Debug / spoofing mode

This is a testing aid, not a production setting. When **debug** is on, an
administrator's detected country can be *forced* to a test value so you can preview
country-specific behavior:

- **Debug** (`debug`, default off) — turns spoofing on.
- **Test type** (`test_type`) — choose whether to spoof a **country** (`0`) or an
  **IP address** (`1`).
- **Test country** (`test_country`) — the ISO 3166 country code to force (used when
  test type is "country").
- **Test IP address** (`test_ip_address`) — an IP to look up and use instead (used
  when test type is "IP address").

Spoofing **only affects users who hold the *Administer ip2country* permission** — on
login they see a status message like *"Using DEBUG value for Country - XX"*. Ordinary
visitors are never spoofed, so this is safe to leave enabled while testing, though
you'll normally turn it off afterward.

## What happens after configuration

- On each user login, the module looks up the account's IP and stores the country in
  the `user.data` service under `ip2country` / `country_iso_code_2`; it's restored
  onto the account when the user is loaded, so other modules can read it.
- Cron refreshes the database on your chosen interval (unless set to 0).
- You can look up any IP in code via the `ip2country.lookup` service
  (`getCountry($ip)` returns the ISO code or FALSE), act on the country with the
  Rules condition/action, serve per-country cached pages with the `ip.country` cache
  context, or query the REST resource at `GET /ip2country/{ip_address}`.

## Related admin routes

- `/admin/config/people/ip2country` — the settings form.
- `/admin/config/people/ip2country/update/{rir}` — trigger a database update.
- `/admin/config/people/ip2country/lookup/{ip_address}` — look up an IP in the UI.

All three require **Administer ip2country**.

## Scripting the settings (optional)

```bash
drush cget ip2country.settings

# use APNIC and update every two weeks
drush php:eval '$c=\Drupal::configFactory()->getEditable("ip2country.settings");
  $c->set("rir","apnic")->set("update_interval",1209600)->save();'

# force country spoofing to Germany (affects admins only)
drush php:eval '$c=\Drupal::configFactory()->getEditable("ip2country.settings");
  $c->set("debug",TRUE)->set("test_type",0)->set("test_country","DE")->save();'
```

## Command-line tools

Three Drush commands complement the UI:

- `drush ip2country:update [--registry=…] [--batch_size=…] [--checksum]` — truncate
  and reload the table from a registry.
- `drush ip2country:lookup <ip>` — show the country for an IPv4 address.
- `drush ip2country:status` — report when and from which registry the database was
  last updated.
