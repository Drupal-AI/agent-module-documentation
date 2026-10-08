# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** module (`media`), which Brandfolder depends on — Drupal enables
  it automatically as a dependency.
- A Brandfolder account and an API key/token for it.
- Outbound HTTPS access from the server to the Brandfolder API.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/brandfolder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/brandfolder -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en brandfolder -y
```

This also enables core Media if it is not already on.

## Next step

Before Drupal can reach your Brandfolder library you must enter your API
credential — and it should be stored as a secret, not in plain config. See
[Configuration](../configuration/index.md).
