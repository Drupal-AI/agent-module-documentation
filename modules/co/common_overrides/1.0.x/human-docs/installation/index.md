# Installation

## Requirements

- **Drupal 9.4 or 10** (`core_version_requirement: ^9.4 || ^10`).
- No other Drupal module dependencies. The search‑heading override applies to the
  node search results page, so core's **Search** module should be in use for the
  override to have anything to act on.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/common_overrides -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/common_overrides -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en common_overrides -y
```

## Verify it worked

Go to **Configuration → Common Overrides** (`/admin/config/common_overrides`) and
confirm the settings form loads. (If the module's **Configure** link is dead due
to the known route‑name mismatch, use the direct URL.) Then set your heading text
and tag as described in [Configuration](../configuration/index.md).
