# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **Address** module (`address`) enabled — this is a required dependency, and
  the field this module enhances. Composer pulls it in automatically with the
  command below.
- A **lookup provider** account or endpoint (see
  [Configuration](../configuration/index.md)) — the autocomplete has to query an
  address-data provider, and that is usually paid or rate-limited.

> **This is a beta release** (1.0.0-beta6). Test it in a non-production environment
> before you depend on it.

## Install with Composer

From the project root:

```bash
composer require drupal/address_autocomplete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the `address` dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/address_autocomplete -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en address_autocomplete -y
```

Drush enables the `address` dependency at the same time. Next, configure the lookup
provider and switch your Address field to the autocomplete widget — see
[Configuration](../configuration/index.md).
