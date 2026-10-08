# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).

The module declares no other module or PHP library dependencies — it builds on
Drupal core's Field system, which is part of a standard install.

## Install with Composer

From the project root:

```bash
composer require drupal/color_element -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/color_element -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en color_element -y
```

## Verify it worked

Go to a content type's **Manage fields** screen and start adding a field — you
should see **Color Element** in the list of available field types. See "How to use
it" on the [overview page](../index.md) for the rest of the setup.
