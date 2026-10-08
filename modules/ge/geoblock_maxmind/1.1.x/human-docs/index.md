# MaxMind Data Source — manual setup guide

**MaxMind Data Source** (`geoblock_maxmind`) plugs a MaxMind GeoIP database into the
[Geoblock](https://www.drupal.org/project/geoblock) module so Geoblock can work out
a visitor's country from their IP address using MaxMind data. It is an add-on for
Geoblock, not a standalone tool: this module supplies the *country data*, while the
actual allow/deny rules — which countries to block or permit — live in Geoblock
itself.

Under the hood it registers a "MaxMind database file" data source that reads a local
`.mmdb` database (a GeoLite2 / GeoIP2 file) and maps each IP to its ISO country code.
Because the lookup is against a local file, country resolution is fast and works
fully offline — there is no per-request call to an external API. You provide the
database in one of two ways: place and maintain the `.mmdb` file yourself at
`private://geoblock_maxmind.mmdb`, or configure a **Download URL** pointing at a
`*.tar.gz` archive that contains the `.mmdb`, and the module will download, extract,
and then refresh it automatically about once a week via cron.

There is a single setting (the Download URL), reached at **Configuration → Geoblock
→ MaxMind settings**. The module requires PHP 8.1+, depends on the **Geoblock**
module and the `librarymarket/maxmind-db-reader` PHP library (both pulled in by
Composer), and needs Drupal's **private file system** configured so it has somewhere
to keep the database. It defines no permission of its own — the settings form reuses
Geoblock's *Administer geoblock* permission — and ships no submodules.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, configure the
   private file system, and enable the module.
2. [Configuration](configuration/index.md) — providing the `.mmdb` database, the
   Download URL, and how the automatic refresh works.

## Where it lives in the admin menu

The settings form is at **Configuration → Geoblock → MaxMind settings**
(`/admin/config/geoblock/maxmind`), gated by Geoblock's **Administer geoblock**
permission. The blocking rules that actually *use* this data are configured in the
Geoblock module.

## How to use it

Install and enable the module (with Geoblock), make sure the private file system is
set up, then either drop a MaxMind `.mmdb` file at `private://geoblock_maxmind.mmdb`
or enter a Download URL on the settings form. Finally, in **Geoblock's** own
configuration, select the "MaxMind database file" data source so Geoblock resolves
countries from MaxMind. See [Configuration](configuration/index.md) for details.
