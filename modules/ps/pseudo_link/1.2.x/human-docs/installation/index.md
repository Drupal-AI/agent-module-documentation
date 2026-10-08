# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- A theme that renders entity views properly (standard content regions) — no extra
  modules are required.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/pseudo_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pseudo_link -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pseudo_link -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Pseudo Link**
(`/admin/pseudo-link-configurations`). If the configurations page loads, the module is
installed. Continue with [Configuration](../configuration/index.md) to enable pseudo
links for your entities and place the field on their display.
