# InfluxDB — manual setup guide

**InfluxDB** (`influxdb`) integrates the
[InfluxDB](https://www.influxdata.com/) time-series database with Drupal.
InfluxDB is an open-source database built for time-stamped data — operations
monitoring, application metrics, IoT sensor readings, real-time analytics — and
this module gives Drupal a clean, configured way to read from and write to it.

At its heart is a **client-factory service**: you enter your server URL,
organization, and access token once, and any code on the site can then ask the
factory for a ready-to-use `InfluxDB2\Client` object to write points or run Flux
queries. Crucially, the access token is **not** stored in plain configuration —
the module uses Drupal's **Key** module, so the settings form only records *which*
Key to use, while the secret itself lives wherever the Key provider keeps it
(an environment variable, a file outside the web root, and so on).

Two optional submodules build on the base:

- **InfluxDB Bucket** (`influxdb_bucket`) lets you define buckets as Drupal config
  entities and create or update them on the remote InfluxDB server from an admin
  screen.
- **InfluxDB Bucket ECA** (`influxdb_bucket_eca`) adds
  [ECA](https://www.drupal.org/project/eca) actions — *Create a Point*, *Write
  Point*, and *Execute a Flux query* — so you can push metrics and run queries
  from no-code ECA models.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the required
   Key module with Composer, and enable the submodules you need.
2. [Configuration](configuration/index.md) — store the token as a Key, fill in the
   connection settings, and (optionally) manage buckets.

## Where it lives in the admin menu

The connection settings form sits at **Configuration → Web services → InfluxDB**
(`/admin/config/services/influxdb`). If you enable the bucket submodule, its
management screen is at `/admin/config/services/influxdb/buckets`.
