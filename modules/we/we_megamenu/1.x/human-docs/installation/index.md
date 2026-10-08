# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other contrib module dependencies and no PHP library requirements. The
  module bundles the front-end libraries it needs (Bootstrap, jQuery UI, Chosen),
  so there is nothing extra to install.

## Install with Composer

From the project root:

```bash
composer require drupal/we_megamenu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/we_megamenu -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en we_megamenu -y
```

## Grant the permission

The mega menu builder is gated by a single, security-sensitive permission,
**Administer Mega Menu**. Grant it only to trusted roles:

```bash
drush role:perm:add administrator 'administer we_megamenu'
```

Or in the UI, go to **People → Permissions** (`/admin/people/permissions`), find
**Administer Mega Menu**, tick it for the appropriate role, and save. (Anonymous
visitors don't need any special permission to *see* a rendered mega menu — only to
edit one.)

## Next steps

Head to [Configuration](../configuration/index.md) to build your first mega menu
and place its block.
