# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1`). The module relies
  on core's Icon API, which is only available from 11.1, so it will not install on
  earlier versions.

There are no third-party Composer or PHP library requirements, and no other module
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap_icons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bootstrap_icons -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bootstrap_icons -y
```

That is all. The Bootstrap Icons pack is now registered with the Icon API and
appears in any icon picker on the site. There is no settings form.
