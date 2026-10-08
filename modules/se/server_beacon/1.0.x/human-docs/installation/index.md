# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2||^11`).
- The **Key** module (`key`) — a required dependency, used to store the
  credentials for talking to the reporting station.
- A reachable **reporting station** (from the companion Report Station project) to
  receive the beacons, plus outbound HTTPS access from your server to reach it.

There are no third-party PHP libraries required.

## Install with Composer

From the project root:

```bash
composer require drupal/server_beacon -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If the Key module is not already present, Composer pulls
it in; you can also add it explicitly with `composer require drupal/key -W`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/server_beacon -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en server_beacon -y
```

Drupal enables the Key module as a dependency if it is not already on.

## Verify it worked

Go to **Configuration → Web services** and confirm a **Server Beacon Reports**
link appears, or visit `/admin/config/services/server-beacon` directly. From there
you can add and edit reports — see [Configuration](../configuration/index.md).
This is a beta release, so test against a non-critical station first.
