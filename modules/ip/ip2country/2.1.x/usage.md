IP-based determination of Country (ip2country) maps a visitor's IP address to an ISO 3166 two-character country code, using free IP-allocation data downloaded from the Regional Internet Registries (RIRs), and records each user's country on login.

---

The module maintains its own `{ip2country}` database table of IP-range → country mappings,
populated from one or all five RIRs (ARIN, RIPE, APNIC, AFRINIC, LACNIC). It exposes an
`ip2country.lookup` service (`getCountry($ip)` → ISO code or FALSE) backed by a single
range query, and an `ip2country.manager` service to (re)load, empty, and count the table.
On `hook_user_login` it looks up the user's country and stores it in the `user.data` service
under `ip2country` / `country_iso_code_2`; `hook_user_load` restores it onto the account object.
`hook_cron` refreshes the database on a configurable interval. Configuration lives in
`ip2country.settings` (RIR, update interval, batch size, MD5 checksum, watchdog logging, plus a
**debug/spoofing** mode that lets an admin force a test country or IP). Admins manage it at
`/admin/config/people/ip2country` (permission `administer ip2country`), or via three Drush
commands (`ip2country:update`, `ip2country:lookup`, `ip2country:status`). It also ships Rules
integration (a "User is in country" condition and a "set user country" action), a REST resource
(`GET /ip2country/{ip_address}`), and an `ip.country` cache context for per-country cached
output. Last-update metadata lives in the State keys `ip2country_last_update` and
`ip2country_last_update_rir`.

---

- Determine a visitor's country from their IP address without a paid GeoIP service.
- Store each user's country code in `user.data` automatically on login.
- Look up any IP's country programmatically via the `ip2country.lookup` service.
- Look up an IP from the command line with `drush ip2country:lookup <ip>`.
- Refresh the IP/country database from a chosen RIR with `drush ip2country:update`.
- Check when the database was last updated with `drush ip2country:status`.
- Populate the database automatically on cron at a configurable interval (e.g. weekly).
- Choose which RIR to pull data from (all, arin, ripe, apnic, afrinic, lacnic).
- Verify downloaded data integrity with an MD5 checksum when the RIR provides one.
- Tune the DB write batch size for the import to trade memory against speed.
- Gate content or actions by country using the Rules "User is in country" condition.
- Set a user's stored country via the Rules "set user country" action.
- Serve per-country cached variations of a page using the `ip.country` cache context.
- Expose country lookups to a decoupled front end via the REST resource `/ip2country/{ip}`.
- Spoof a test country for an admin (debug mode) to preview country-specific behavior.
- Spoof a test IP address for an admin to check a specific network's country.
- Log database updates to the watchdog/dblog for auditing.
- Redirect or localize users based on their detected country (with Rules).
- Show or hide blocks by country via a Rules-driven condition.
- Restrict access to certain pages for visitors from specific countries.
- Empty and rebuild the IP/country table when data becomes stale.
- Count how many IP ranges are currently loaded (`getRowCount()`).
- Disable automatic updates entirely by setting the update interval to 0.
- Migrate legacy ip2country settings/user data from Drupal 6/7 (bundled migrations).
- Feed detected country into other modules through the `country_iso_code_2` user data key.
