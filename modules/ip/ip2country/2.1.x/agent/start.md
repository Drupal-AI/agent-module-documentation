# ip2country — agent index

Maps a visitor's **IP → ISO 3166 country code** using free RIR allocation data it downloads into
its own `{ip2country}` table, and records each user's country on login in `user.data`
(`ip2country` / `country_iso_code_2`).

Key facts:
- Configure route: `ip2country.settings` → `/admin/config/people/ip2country`, permission
  **`administer ip2country`** (the module's only permission).
- Config object `ip2country.settings` keys: `rir`, `update_interval`, `batch_size`,
  `md5_checksum`, `watchdog`, and debug/spoofing: `debug`, `test_type`, `test_country`,
  `test_ip_address`.
- Services: **`ip2country.lookup`** (`getCountry($ip)` → ISO code|FALSE) and
  **`ip2country.manager`** (`updateDatabase`, `emptyDatabase`, `getRowCount`).
- State: `ip2country_last_update` (timestamp), `ip2country_last_update_rir`.
- Drush: `ip2country:update`, `ip2country:lookup`, `ip2country:status`.
- Integrations: Rules condition `ip2country_user_country`, Rules action `ip2country_set_country`,
  REST resource `ip_lookup` (`GET /ip2country/{ip_address}`), cache context `ip.country`.

Docs:
- **Config keys, routes, debug/spoofing, permission** → [configure/settings.md](configure/settings.md)
- **Services (lookup + manager), user.data, State, Db event** → [api/services.md](api/services.md)
- **Drush commands** → [drush/commands.md](drush/commands.md)
- **Rules / REST / cache-context integrations** → [plugins/integrations.md](plugins/integrations.md)
