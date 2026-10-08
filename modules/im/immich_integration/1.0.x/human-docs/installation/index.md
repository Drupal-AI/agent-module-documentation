# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core's **System** module (always present).
- A reachable, self‑hosted **Immich server**, and an **API key** generated in that
  Immich instance for the account you want Drupal to act as.

There are no third‑party Composer or PHP library requirements. Note that this
module is **not covered by Drupal's security advisory policy** — review it yourself
before using it on a sensitive site.

## Install with Composer

From the project root:

```bash
composer require drupal/immich_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/immich_integration -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en immich_integration -y
```

## Verify it worked

Go to **Configuration → Media → Immich** (`/admin/config/media/immich`), enter your
Immich server URL and API key, and click **Test Connection**. A successful test
(reporting the server's version) confirms Drupal can reach and authenticate against
your Immich server. See [Configuration](../configuration/index.md) for the full
walkthrough.
