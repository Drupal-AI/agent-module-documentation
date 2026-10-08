# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **Field** module (`field`), which is present on every standard site and
  enabled automatically as a dependency.
- No third-party Composer or PHP library requirements.

Note that this project is **not covered by Drupal's security advisory policy**, and
the 1.0.x branch is a development release — test before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_address -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_address -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_address -y
```

There is no settings form to visit afterwards. You add the address as a **field**
on the content type or entity where you want it — see the main guide's
[How to use it](../index.md#how-to-use-it) section.
