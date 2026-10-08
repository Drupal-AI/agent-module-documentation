# Geoblock — settings & enforcement

Config object: **`geoblock.settings`** (schema in `config/schema/geoblock.schema.yml`).
Admin form: route `geoblock.settings` at **`/admin/config/geoblock`**, permission
**`administer geoblock`**. There is no Drush command — set values via the form or
`drush config:set geoblock.settings <key> <value>`.

## Keys (shipped defaults from `config/install/geoblock.settings.yml`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `data_source` | string | `''` | Plugin id of the `geoblock_data_source` used to geolocate the IP. **Empty = module disabled.** No plugin ships (see [../plugins/data-source.md](../plugins/data-source.md)). |
| `applicable_methods` | string[] | `[CONNECT, DELETE, PATCH, POST, PUT]` | HTTP methods to which restrictions apply. **GET/HEAD absent by default**, so page views are not blocked unless you add them. |
| `restriction_type` | string | `''` | `''` = no country restriction; `allow` = only listed countries allowed; `block` = listed countries blocked. |
| `restriction_country_codes` | string[] | `[]` | ISO 3166-1 alpha-2 codes (e.g. `US`, `RU`, `CN`), validated via `league/iso3166`. |
| `require_domestic_use` | bool | `false` | If true, block any IP whose current country differs from its registered country. |
| `enable_logging` | bool | `false` | If true, log each enforced restriction (class name, method, URI, IP, country codes) to the `geoblock` channel. |

## How enforcement works
`\Drupal\geoblock\EventSubscriber\RequestHandler` (service `geoblock.request_handler`) subscribes
to `KernelEvents::REQUEST`:

1. `applies()` returns FALSE unless a valid `data_source` plugin exists **and** the request
   method is in `applicable_methods`.
2. The client IP (`$request->getClientIp()`) is wrapped in an `IPAddress` and passed to the data
   source plugin's `locate()`, which sets its country / registered-country codes.
3. Each collected restriction (tagged `geoblock_restriction`) is checked; the **first** one that
   both `applies()` and `enforce()` returns TRUE sends a `403 Forbidden` plain-text response.

Restrictions provided:
- **`CountryCodeRestriction`** — active when `restriction_type` is `allow`/`block` and the
  country list is non-empty. `block`: 403 if the IP's country is in the list. `allow`: 403 if it
  is **not** in the list. (If the country can't be determined, this restriction does not fire.)
- **`DomesticRestriction`** — active when `require_domestic_use` is true; 403 if
  `IPAddress::isDomesticUse()` is false (current country != registered country).

Enforcement is fail-safe: exceptions during the request event are caught (and logged if logging
is on) and never hard-block the site.

## Quick recipes
Block two countries for the default (mutating) methods:
```
drush config:set geoblock.settings restriction_type block
drush config:set geoblock.settings restriction_country_codes.0 RU
drush config:set geoblock.settings restriction_country_codes.1 KP
```
Allow-list only US + CA:
```
drush config:set geoblock.settings restriction_type allow
drush config:set geoblock.settings restriction_country_codes.0 US
drush config:set geoblock.settings restriction_country_codes.1 CA
```
Remember to also select a `data_source` plugin, or none of this takes effect.
