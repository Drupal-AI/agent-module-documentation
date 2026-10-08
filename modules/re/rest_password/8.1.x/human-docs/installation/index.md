# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 ||
  ^11`).
- Core's **RESTful Web Services** module (`rest`) — a required dependency, which
  Drupal enables automatically.
- Strongly recommended: the **REST UI** contrib module (`restui`), which gives
  you an admin screen to enable and configure the REST resources. Without it you
  would enable them via configuration import.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/rest_password -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you want the admin screen for REST resources, also
require REST UI:

```bash
composer require drupal/restui -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/rest_password -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rest_password -y
# optionally, for the admin UI:
drush en restui -y
```

The module ships no submodules. The two REST resources are **not** active until
you enable them — see [Configuration](../configuration/index.md).
