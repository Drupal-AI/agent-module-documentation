# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 7.4** or later.
- An **active Schema App subscription** and a Schema App project in your account —
  the module is a client for that hosted service and does nothing useful without
  it.

There are no additional Drupal module dependencies and no PHP‑library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/schemaapp -W
```

The Composer package name (`drupal/schemaapp`) matches the module's machine name
(`schemaapp`). The `-W` (`--with-all-dependencies`) flag lets Composer update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schemaapp -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en schemaapp -y
```

## Next step

The module does nothing until it is connected to your Schema App account. Continue
to [Configuration](../configuration/index.md) to supply the connection details.
