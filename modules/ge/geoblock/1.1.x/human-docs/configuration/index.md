# Configuration

Geoblock's behavior is driven by a single settings form. Everything lives in the
`geoblock.settings` config object, so you can also set values in code or with
`drush config:set`.

## Open the settings form

1. Log in as a user with the **Administer geoblock** permission.
2. Go to **Configuration → Geoblock**, or navigate directly to
   `/admin/config/geoblock`.

## The settings, field by field

### Data source

The geolocation plugin used to turn a visitor's IP into a country. **This is the
switch that turns Geoblock on.** If it's empty (or points at a plugin that isn't
installed), the module does nothing at all — no request is ever blocked. Geoblock
ships no data source, so this select only lists options once you've enabled a
module that provides a `geoblock_data_source` plugin. (Config key: `data_source`,
default empty.)

### Applicable methods

The HTTP methods the country rules apply to. The default is **CONNECT, DELETE,
PATCH, POST, PUT** — i.e. *mutating* requests. Note that **GET and HEAD are absent
by default**, so ordinary page views are never blocked unless you deliberately add
them. Restricting only POST/PUT/PATCH/DELETE is a common pattern: it locks down
form submissions and API writes while keeping browsing, caching, and crawlers
working. (Config key: `applicable_methods`.)

### Restriction type + country codes

These two work together:

- **Restriction type** — choose *no country restriction* (off), **allow**, or
  **block**.
  - **allow**: only visitors from the listed countries may reach the site;
    everyone else gets a 403.
  - **block**: visitors from the listed countries are denied; everyone else is
    allowed.
- **Country codes** — the list the rule applies to, as ISO 3166-1 alpha-2 codes
  (e.g. `US`, `CA`, `RU`, `KP`, `CN`). They're validated against `league/iso3166`,
  so an invalid code is rejected.

If the data source can't determine a visitor's country, this particular rule does
not fire (it fails open rather than blocking a request it can't classify). (Config
keys: `restriction_type`, `restriction_country_codes`.)

### Require domestic use

A checkbox. When ticked, Geoblock blocks any IP whose *current* country differs
from the country it is *registered* in — a rough heuristic for spotting
VPN/proxy traffic. It relies on your data source populating both the country and
registered-country values. You can combine this with an allow/block list for
layered restriction. (Config key: `require_domestic_use`, default off.)

### Enable logging

A checkbox. When on, every enforced block is written to the `geoblock` log
channel, recording which restriction fired, the HTTP method, the URI, the IP, and
the country codes involved. Handy for auditing or tuning your rules before you
tighten them. (Config key: `enable_logging`, default off.)

## How enforcement works (what happens on each request)

For a request whose method is in **Applicable methods** (and only if a valid data
source exists), Geoblock geolocates the client IP, then checks each restriction in
turn. The **first** restriction that both applies and is violated sends a plain
`403 Forbidden` with the message *"The requested resource is inaccessible due to
geographical restrictions."*

- The **country-code restriction** fires when *restriction type* is allow/block
  and the list is non-empty.
- The **domestic-use restriction** fires when *require domestic use* is on and the
  IP is being used outside its registered country.

Enforcement is **fail-safe**: if anything throws an exception while checking, the
error is logged (when logging is on) and the request is *not* hard-blocked — a
broken lookup won't take your whole site offline. IP addresses in private/reserved
ranges have no country and are treated as non-locatable.

## Setting values without the form (drush)

Block two countries for the default (mutating) methods:

```bash
drush config:set geoblock.settings restriction_type block
drush config:set geoblock.settings restriction_country_codes.0 RU
drush config:set geoblock.settings restriction_country_codes.1 KP
```

Allow only the US and Canada:

```bash
drush config:set geoblock.settings restriction_type allow
drush config:set geoblock.settings restriction_country_codes.0 US
drush config:set geoblock.settings restriction_country_codes.1 CA
```

Remember: none of this takes effect until a `data_source` plugin is also selected.

## A note on IP source

Geoblock reads the client IP from the incoming request. If your site sits behind a
reverse proxy, load balancer, or CDN, make sure Drupal's trusted-proxy settings
(`settings.php` reverse-proxy configuration) are correct — otherwise every visitor
may appear to come from the proxy's IP, and country detection (and therefore your
rules) will be wrong.
