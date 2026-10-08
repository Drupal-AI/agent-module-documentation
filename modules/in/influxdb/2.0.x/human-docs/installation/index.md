# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Key** module (`key`) — a hard dependency, used to store the InfluxDB
  access token securely. Composer pulls it in automatically.
- A reachable **InfluxDB server** (v2 / Flux) with an organization and an API
  token you can use.
- For the ECA submodule only: the **ECA** module
  (`drupal/eca`).

There are no additional PHP library requirements — the InfluxDB PHP client comes
in through Composer as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/influxdb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including the Key module) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/influxdb -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en influxdb -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| InfluxDB Bucket | `influxdb_bucket` | Define buckets as config entities and create/update them on the remote server from an admin screen at `/admin/config/services/influxdb/buckets`. |
| InfluxDB Bucket ECA | `influxdb_bucket_eca` | ECA actions — *Create a Point*, *Write Point*, *Execute a Flux query* — for driving InfluxDB from ECA models. Requires the ECA module. |

For example:

```bash
drush en influxdb_bucket -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Web services → InfluxDB**
(`/admin/config/services/influxdb`). If the settings form loads, the module is
installed. Next, store your token as a Key and fill in the connection details —
see [Configuration](../configuration/index.md). The form will ping your server on
save and report the InfluxDB version, which is the quickest confirmation that the
connection works.
