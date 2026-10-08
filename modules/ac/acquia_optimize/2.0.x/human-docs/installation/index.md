# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- An **Acquia Web Governance** account (formerly Acquia Optimize) and its **API
  key** — the module reports findings from that platform, so you need a subscription
  to connect to.

It has no Drupal module dependencies and no extra PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_optimize -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/acquia_optimize -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_optimize -y
```

## Next steps

The module does nothing until you connect it to your Acquia Web Governance account
and grant the right permissions. Head to [Configuration](../configuration/index.md)
to enter the API key, set the two permissions, and — importantly — read the note on
keeping that key out of your exported configuration.
