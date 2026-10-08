# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no other module dependencies and no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sidenotes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sidenotes -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sidenotes -y
```

## Next step

Enabling the module does not start rendering sidenotes on its own — you need to set
your defaults and turn the Sidenotes text filter on for the text formats you author in.
Continue to [Configuration](../configuration/index.md).
