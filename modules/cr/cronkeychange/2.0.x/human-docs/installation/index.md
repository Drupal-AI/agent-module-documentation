# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).

That's it — the module has no other module dependencies and no third‑party PHP or
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cronkeychange -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cronkeychange -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cronkeychange -y
```

As soon as it is enabled, the **Change cron key** fieldset appears on the core
Cron settings page. See [Configuration](../configuration/index.md) for how to
rotate the key.
