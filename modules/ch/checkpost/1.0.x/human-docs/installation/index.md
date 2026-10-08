# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No other module dependencies, and no third‑party Composer or PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/checkpost -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/checkpost -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en checkpost -y
```

> **Important:** Add your rules *before* you turn enforcement on. If you enable
> enforcement with an empty or wrong allowlist you can lock yourself out. Enabling
> the module alone is safe — it does nothing until you switch enforcement on in the
> settings form.

## Verify it worked

Go to **Configuration → Development → Checkpost**
(`/admin/config/development/checkpost`). You should see the settings form with
fields for allowed pages, headers, IPs, and CIDR ranges, plus the master
enable/disable toggle. Continue to [Configuration](../configuration/index.md) to
set up your allowlist.
