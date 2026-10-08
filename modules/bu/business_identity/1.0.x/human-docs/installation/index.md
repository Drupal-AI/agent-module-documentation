# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11||^12`).
- Core's **System** and **Config** modules, which are part of a standard Drupal
  install and are enabled automatically.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/business_identity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/business_identity -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en business_identity -y
```

After enabling, grant the module's permission to the appropriate roles under
**People → Permissions**, then fill in your organisation's details as described in
[Configuration](../configuration/index.md).
