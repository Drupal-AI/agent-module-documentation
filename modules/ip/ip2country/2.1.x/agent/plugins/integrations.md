# ip2country integrations (Rules / REST / cache context)

The module defines **plugin instances** for other subsystems (it does not define a plugin type
of its own). All read country via `ip2country.lookup` or `user.data`.

## Rules condition — `ip2country_user_country`

`src/Plugin/Condition/UserInCountry.php`, label *"User is in country (based on IP address)"*,
category *User*. Context: `countries` (multiple string values, options from
`CountryListOptions`). Evaluates TRUE when the current user's country (from `user.data`
`country_iso_code_2`, falling back to a live lookup) is in the selected list. Requires the
`rules` module. Use it in a Rules reaction to gate actions by country.

## Rules action — `ip2country_set_country`

`src/Plugin/RulesAction/SetUserCountry.php`, label *"Add country data to the user_data table"*.
Context: `user` (entity:user) and `country_code` (string ISO code). Writes
`country_iso_code_2` into that user's `user.data`. Requires `rules`.

## REST resource — `ip_lookup`

`src/Plugin/rest/resource/Ip2CountryResource.php`. Canonical URI
**`GET /ip2country/{ip_address}`** (id `ip_lookup`). Returns the country for the given IP via
the lookup service (400 on a malformed IP, 404 when not found). Enable and grant it through the
core `rest` module's resource configuration like any REST resource.

## Cache context — `ip.country`

`src/Cache/Context/Ip2CountryCacheContext.php` (service `cache_context.ip.country`, tag
`cache.context`). `getContext()` returns the current request IP's country code, so adding
`'ip.country'` to a render array's `#cache['contexts']` produces **per-country** cached
variations. Label: *"Country based on IP address"*.

## Also present

- **Validation constraint** `IpAddress` (`src/Plugin/Validation/Constraint/`) used by the
  `test_ip_address` config value.
- **Options provider** `CountryListOptions` (`src/TypedData/Options/`) supplying the country list
  to the Rules condition.
- **Event** `DbUpdatedEvent` dispatched by `ip2country.manager` after a successful DB reload —
  subscribe to react to refreshes.
