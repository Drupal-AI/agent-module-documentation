# GeoIP Auto-Update — manual setup guide

**GeoIP Auto-Update** (`geoip_autoupdate`) keeps the MaxMind **GeoLite2‑Country**
database up to date automatically. On every Drupal cron run it checks MaxMind for
a newer build and, when one exists, downloads it, extracts the `.mmdb` file, and
stores it in your site's **private filesystem** — so the database is never exposed
in the public web root. It also provides a ready‑to‑use GeoLocator plugin, **Local
dataset (private filesystem)** (`local_private`), that the [GeoIP](https://www.drupal.org/project/geoip)
module reads from.

The module is an extension of the GeoIP module (a hard dependency). It is smart
about MaxMind's daily download limits: before downloading, it makes a cheap
authenticated HEAD request and compares the `Last-Modified` header against the
value it last saved, so it only pulls a new archive when the database has actually
changed. There is also a **Download now** button for forcing an immediate refresh
when you want to test your credentials or update on demand.

To use it you need a free MaxMind account. You enter your **Account ID** and
**License Key** on the module's settings form, point GeoIP at the
`local_private` locator, and let cron do the rest. The database ends up at
`private://GeoLite2-Country.mmdb`, and the module also fixes the site status page
so it correctly reports the private database and its age (warning you if it is
more than a month old) instead of complaining about a missing public file.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   the private‑filesystem / PHP `phar` prerequisites.
2. [Configuration](configuration/index.md) — the settings form (Account ID,
   License Key, Download now) and wiring GeoIP up to the private database.

## Where it lives in the admin menu

Once enabled, the module's own settings form sits at **Configuration → System →
GeoIP → Auto-update** (`/admin/config/system/geoip/autoupdate`). You also choose
the active locator on the GeoIP module's settings page at **Configuration →
System → GeoIP** (`/admin/config/system/geoip`).
