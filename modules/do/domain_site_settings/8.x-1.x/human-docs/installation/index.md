# Installation

> **Before you install:** this module is deprecated and unsupported. For new
> projects use **Domain Config** and **Domain Config UI** (submodules of the Domain
> project) instead. Install Domain Site Settings only for an existing site that
> already depends on it.

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **Domain** module (`domain`) and its **Domain Configuration** submodule
  (`domain_config`), which stores the per-domain configuration overrides.

There are no third-party PHP or Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_site_settings -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/domain_site_settings -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_site_settings -y
```

This also enables `domain` and `domain_config` if they are not already on.

## Verify it worked

Grant the **`domain site settings`** permission to the appropriate role
(**People → Permissions**), then go to **Configuration → Domain → Domain Site
Settings** (`/admin/config/domain/domain_site_settings`). You should reach the
per-domain settings form. See [Configuration](../configuration/index.md) next.
