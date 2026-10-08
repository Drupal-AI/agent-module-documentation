# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- An **ActiveNet (Active Network)** account with API access, so you can obtain
  the API credentials.

There are no third-party Composer or PHP library requirements. This module is
typically deployed as part of a YMCA Website Services site.

## Install with Composer

From the project root:

```bash
composer require drupal/activenet -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/activenet -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en activenet -y
```

After enabling, grant the module's permission to the appropriate administrators
under **People → Permissions**, then continue to
[Configuration](../configuration/index.md) to connect to ActiveNet.
