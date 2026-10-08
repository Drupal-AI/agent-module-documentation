# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Configuration Manager** module (`config`) — Broken Configuration
  depends on it and Drupal enables it automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/broken_config -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/broken_config -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en broken_config -y
```

After enabling, grant the **Scan broken configuration** permission
(`scan broken configuration`) to the roles that should be able to run the scan.

> **Version note:** this is an early release (1.0.0‑beta1). Try it on a non‑production
> copy first.
