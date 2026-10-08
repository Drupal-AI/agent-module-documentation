# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).

The module lists no other module dependencies and no third-party Composer or PHP
libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/afterburner -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/afterburner -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en afterburner -y
```

That is all the installation there is. From here Afterburner is used in code — see
[How to use it](../index.md#how-to-use-it) on the overview page.
