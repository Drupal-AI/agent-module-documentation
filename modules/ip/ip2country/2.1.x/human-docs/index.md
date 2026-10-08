# IP-based determination of Country — manual setup guide

**IP-based determination of Country** (`ip2country`) works out which country a
visitor is in from their IP address, and records each user's country when they log
in. Unlike commercial GeoIP services, it uses **free** IP-allocation data published
by the Regional Internet Registries (RIRs) — ARIN, RIPE, APNIC, AFRINIC and LACNIC —
which it downloads into its own database table and maps to ISO 3166 two-letter
country codes.

Once populated, the module gives you an `ip2country.lookup` service to resolve any
IP to a country in code, stores each user's detected country in `user.data` on
login (so other modules can read it), and keeps the data fresh automatically on cron
at an interval you choose. It also ships several integrations out of the box: a
Rules condition ("User is in country") and action ("set user country"), a REST
resource (`GET /ip2country/{ip_address}`) for decoupled front ends, and an
`ip.country` cache context so you can serve per-country cached variations of a page.
Three Drush commands let you update, look up, and check the status of the database
from the command line.

Because the database starts empty, the one required setup step after enabling is to
**populate it** — either by running an update from the settings page or Drush, or by
letting cron do it. The settings form (**Configuration → People → IP-based
determination of Country**) lets you pick which registry to pull from, the
auto-update interval, the import batch size, optional checksum verification and
logging, plus a handy **debug/spoofing** mode that lets an administrator force a test
country or IP to preview country-specific behavior. The module defines one
permission (*Administer ip2country*), provides its own config and Drush commands, and
has no dependencies beyond Drupal core.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and populate the database for the first time.
2. [Configuration](configuration/index.md) — the settings form, registry choice,
   update schedule, and the debug/spoofing mode.

## Where it lives in the admin menu

The settings form is at **Configuration → People → IP-based determination of
Country** (`/admin/config/people/ip2country`), gated by the **Administer
ip2country** permission.

## How to use it

Enable the module, then populate the database (via the settings page, or
`drush ip2country:update`). After that, users get a country stamped in `user.data`
on login, and you can look up any IP — for example from the command line with
`drush ip2country:lookup 8.8.8.8`, or in code via the `ip2country.lookup` service.
Use the Rules integration or the `ip.country` cache context to actually act on the
detected country. See [Configuration](configuration/index.md) for the settings.
