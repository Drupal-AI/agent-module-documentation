# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other module dependencies, and no third-party Composer or PHP library
  requirements.
- To attach the widgets to fields you will use core's **Field UI** (part of
  standard installs).

## Install with Composer

From the project root:

```bash
composer require drupal/brazilian_ids -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/brazilian_ids -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en brazilian_ids -y
```

There is no settings page. Once enabled, add a text field to a content type and
choose the CPF, CNPJ, or CPF/CNPJ widget on its form display — see the
[overview](../index.md#how-to-use-it).
