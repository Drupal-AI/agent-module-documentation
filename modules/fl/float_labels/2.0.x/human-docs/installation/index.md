# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third-party Composer or PHP library requirements, and no other module
  dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/float_labels -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/float_labels -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en float_labels -y
```

## Verify it worked

Open the Float Labels settings form (see [Configuration](../configuration/index.md)
— reachable from the module's **Configure** link on the **Extend** page). Add a
form ID, save, then load that form and confirm its labels float up on focus/input.
