# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Visitors need **JavaScript enabled** to pass the challenge, so consider the
  effect on legitimate no-JS clients before protecting a path everyone must reach.

There are no third-party Composer or PHP library requirements, and no other module
dependencies.

> **Alpha release.** This module is at `1.0.0-alpha3`. Test it thoroughly before
> depending on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/botbuster -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/botbuster -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en botbuster -y
```

After enabling, open the settings form to choose which paths to protect — see
[Configuration](../configuration/index.md).
