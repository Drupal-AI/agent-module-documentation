# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- No modules outside Drupal core are required, and there are no third‑party PHP
  library requirements.

This is the 1.0.x branch and is not covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/config_warning -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_warning -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_warning -y
```

## Verify it worked

The warning is **disabled by default**, so enabling the module alone shows nothing
yet. Go to **Configuration → Development → Config warning**
(`/admin/config/development/config-warning`), confirm the settings form loads, then
follow [Configuration](../configuration/index.md) to enable the message and set its
text. After enabling it, open a config-altering admin form (for example a view or the
permissions page) and confirm your warning appears.
