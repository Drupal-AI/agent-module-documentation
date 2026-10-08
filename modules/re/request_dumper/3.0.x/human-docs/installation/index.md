# Installation

## Requirements

- **Drupal 11 only** (`core_version_requirement: ^11`). This release drops support
  for Drupal 9 and 10 — on those versions, use the `2.2.x` release instead.
- No other modules are required.
- A writeable **non-public** filesystem for the dumps — by default the temporary
  stream (`temporary://`). The `public` scheme is intentionally not an option.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/request_dumper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. On Drupal 11, Composer resolves to the `3.0.x` branch; to
pin it explicitly:

```bash
composer require "drupal/request_dumper:^3.0" -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/request_dumper -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en request_dumper -y
```

Enabling the module does **not** start capturing anything — dumping stays off
until you turn it on from the settings form.

## Verify it worked

Log in as a user with **Administer site configuration** and open **Configuration
→ Development → Request Dumper** (`/admin/config/development/request-dumper`). The
enable form should load. See [Configuration](../configuration/index.md) to start a
capture.
