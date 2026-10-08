# Entity Metrics — manual setup guide

**Entity Metrics** (`entity_metrics`) records **page views and downloads** for
entities on your Drupal site — counting how often each entity is viewed and how
often its files are downloaded, so editors and administrators can see which content
is actually getting attention. Instead of relying solely on an external analytics
product, the counts live in Drupal, in the module's own tables, tied to the entities
themselves.

To enrich the raw counts with geographic information it can read a **local MaxMind
GeoLite2-City database**. The database file is downloaded and kept up to date by the
**GeoIP Autoupdate** (`geoip_autoupdate`) module, which Entity Metrics depends on;
Entity Metrics itself only reads the local file, and does not call any remote
geolocation service or hold any geolocation credential of its own. It runs on
Drupal 10 and 11.

Note that at the time of writing Entity Metrics is a **beta** release. Because view
and download counts (and any geolocation derived from them) can be sensitive, decide
carefully which roles may place and see the module's metrics blocks.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   `geoip_autoupdate` dependency, enable it, and set up the local geolocation
   database.

## Where it lives in the admin menu

Entity Metrics records views and downloads for entities and surfaces the resulting
metrics through two blocks (a view-count block and a Leaflet map block) plus a
settings form. Its geolocation database is managed by the **GeoIP Autoupdate**
module.

## How to use it

1. Install and enable the module and its `geoip_autoupdate` dependency (see
   [Installation](installation/index.md)).
2. Configure `geoip_autoupdate` to download a GeoLite2-**City** database so the map
   features have data to read.
3. Place the view-count and/or map block where you want the metrics shown.
4. As visitors view content and download files, the counts accumulate against each
   entity for review.
