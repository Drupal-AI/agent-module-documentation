# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other Drupal modules or third-party libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/advanced_403_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/advanced_403_redirect -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_403_redirect -y
```

After enabling, grant the module's permission on **People → Permissions** to the
roles that should manage the redirect, then set your destination in
[Configuration](../configuration/index.md).
