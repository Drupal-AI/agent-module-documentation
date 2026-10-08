# Installation

## Requirements

Obfuscate needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** (`field`) and **Filter** (`filter`) modules — both are part of a
  standard Drupal install.
- The PHP **mbstring** extension (`ext-mbstring`), which nearly all PHP installations
  already have enabled.

There are no other third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/obfuscate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/obfuscate -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en obfuscate -y
```

After enabling, choose your site-wide obfuscation method and grant the administration
permission — see [Configuration](../configuration/index.md) — then apply obfuscation
wherever your addresses appear (field formatter, text filter, Twig, or code), as described
in the [overview](../index.md#how-to-use-it).

There are no submodules.
