# Installation

## Requirements

- **Drupal 8.7.7, 9, 10, or 11** (`core_version_requirement: ^8.7.7 || ^9 || ^10 || ^11`).
- No other module dependencies and no third-party libraries.

The **Token** module (`drupal/token`) is an optional suggestion — it adds a token
browser and more tokens to the Entity Prepopulate settings box, but is not
required.

## Install with Composer

From the project root:

```bash
composer require drupal/epp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. To add the optional Token module at the same time:

```bash
composer require drupal/epp drupal/token -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/epp -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en epp -y
```

If you installed Token as well, enable it too:

```bash
drush en epp token -y
```

There is no site-wide configuration step — you set prepopulate values on
individual fields. See [Configuration](../configuration/index.md).
