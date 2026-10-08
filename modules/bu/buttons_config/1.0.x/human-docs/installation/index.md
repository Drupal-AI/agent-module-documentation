# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

Buttons Config has no other module dependencies and no third-party Composer or PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/buttons_config -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/buttons_config -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en buttons_config -y
```

After enabling, set the button labels for your content and media types as
described in [Configuration](../configuration/index.md).
