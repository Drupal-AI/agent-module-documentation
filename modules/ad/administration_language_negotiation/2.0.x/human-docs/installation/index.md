# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- Core's **Locale** module (`locale`) enabled — this is the only dependency, and
  Drupal enables it automatically when you turn on this module. (Locale in turn
  requires the core Language module, and you need at least two languages
  configured for the admin-language feature to be meaningful.)

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/administration_language_negotiation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/administration_language_negotiation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en administration_language_negotiation -y
```

Enabling the module does **not** change any behavior on its own — the new
"Administration language" detection method starts out switched off. Continue to
[Configuration](../configuration/index.md) to turn it on, order it above the
other interface-language methods, and grant the permission.
