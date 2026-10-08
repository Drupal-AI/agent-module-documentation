# ip2country Drush commands

Defined in `src/Drush/Commands/Ip2CountryDrushCommands.php` (Drush 12+ attributes).

## `ip2country:update` (aliases `ip-update`, `ip2country-update`)

Truncates and reloads the `{ip2country}` table from a Regional Internet Registry.

```bash
drush ip2country:update --registry=ripe
drush ip2country:update --registry=apnic --batch_size=200 --checksum
```

Options (fall back to `ip2country.settings` when omitted):
- `--registry` — `all` (default/preferred), `afrinic`, `apnic`, `arin`, `lacnic`, `ripe`.
- `--batch_size` — rows per insert (default 200).
- `--checksum` — validate the download with an MD5 checksum.

Prints "Completed / Database updated from @registry server. Table contains @rows rows." on
success (and logs to watchdog if `watchdog` is on), or "Failed." otherwise.

## `ip2country:lookup <ip_address>` (aliases `ip-lookup`, `ip2country-lookup`)

Returns the country for an IPv4 dotted-quad address as a table (IP address / Country /
Country code).

```bash
drush ip2country:lookup 8.8.8.8
drush ip2country:lookup 8.8.8.8 --field=name   # just the country name
```

Prints "IP address not found in the database." when the table has no matching range (including
when the DB has never been loaded).

## `ip2country:status` (aliases `ip-status`, `ip2country-status`)

Shows when and from which RIR the database was last updated, read from the State keys
`ip2country_last_update` / `ip2country_last_update_rir`:

```bash
drush ip2country:status
# "Database last updated on <date> at <time> from <RIR> server." or "Database is empty."
```

All three commands are `#[ValidateModulesEnabled(['ip2country'])]`.
