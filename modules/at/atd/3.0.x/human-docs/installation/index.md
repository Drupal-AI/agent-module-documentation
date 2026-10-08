# Installation

## Requirements

ATD needs:

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1`).
- Core's **Locale** module (`locale`) — enabled automatically as a dependency.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/atd -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/atd -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en atd -y
```

Core's Locale module is enabled automatically as a dependency. Once enabled, use
ATD alongside the standard translation tools under **Configuration → Regional and
language** — see the [overview guide](../index.md#how-to-use-it).
