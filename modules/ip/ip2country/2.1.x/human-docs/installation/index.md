# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No other module dependencies and no third-party Composer libraries.
- **Outbound HTTP** from your web server, so the module can download IP-allocation
  data from the Regional Internet Registries.
- Optional: the **Rules** module, if you want to use the bundled "User is in
  country" condition and "set user country" action; and core's **REST/serialization**
  setup if you want to expose the `/ip2country/{ip}` resource.

## Install with Composer

From the project root:

```bash
composer require drupal/ip2country -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ip2country -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ip2country -y
```

## Populate the database (required first step)

The IP-to-country table starts **empty**, so no lookups work until you load it once.
Do it in whichever way suits you:

- **From Drush** (recommended for the first load):

  ```bash
  drush ip2country:update
  # or pull from a specific registry, e.g. RIPE:
  drush ip2country:update --registry=ripe
  ```

- **From the settings page** — go to **Configuration → People → IP-based
  determination of Country** and trigger an update there.

- **Via cron** — with a non-zero update interval configured, cron will populate and
  then refresh the table on schedule.

Downloading and importing the full dataset can take a little while. Check it worked
with:

```bash
drush ip2country:status          # when/where it last updated
drush ip2country:lookup 8.8.8.8  # should return a country
```

## Grant the permission

Grant **Administer ip2country** at **People → Permissions**
(`/admin/people/permissions`) to the roles that should manage the module and use its
admin lookup/update pages. Then continue to
[Configuration](../configuration/index.md).
