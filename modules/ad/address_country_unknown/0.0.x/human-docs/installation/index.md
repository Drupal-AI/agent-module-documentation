# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **Address** module (`address`) enabled — a required dependency, and the field
  this module enhances. Composer pulls it in automatically.

There are no third-party Composer or PHP library requirements.

> **Note:** this is an early alpha release (0.0.1-alpha1). Test it before relying
> on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/address_country_unknown -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the `address` dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/address_country_unknown -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en address_country_unknown -y
```

Drush enables the `address` dependency at the same time. There's no configuration
page — set the module's widget and formatter on your Address field's **Manage form
display** and **Manage display**, as described in
[How to use it](../index.md#how-to-use-it).
