# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Domain** module (`domain`).
- The **Redirect** module (`redirect`), version **1.12.0 or newer** — this module
  extends it.

There are no third-party PHP or Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_path_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed, including pulling in a compatible Redirect release.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/domain_path_redirect -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_path_redirect -y
```

This also enables `domain` and `redirect` if they are not already on.

## Verify it worked

Go to **Configuration → Search and metadata → Domain Path Redirect**
(`/admin/config/search/domain_path_redirect`). You should see a listing page with
an action link to add a new domain path redirect. See
[Configuration](../configuration/index.md) for creating one.
