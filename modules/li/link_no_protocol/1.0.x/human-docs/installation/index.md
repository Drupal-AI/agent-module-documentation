# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Link** module (`link`) enabled — this is the only dependency, and it is part of
  Drupal core.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/link_no_protocol -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/link_no_protocol -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_no_protocol -y
```

Make sure core's Link module is enabled too (it usually already is):

```bash
drush en link -y
```

Once enabled, the **Link No Protocol** widget becomes selectable on any Link field's
*Manage form display* screen — see the [main page](../index.md#how-to-use-it) for how to
turn it on for a field.
