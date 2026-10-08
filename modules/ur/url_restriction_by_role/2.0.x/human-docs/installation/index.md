# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other modules, and no third‑party Composer or PHP libraries. It uses only
  core services (the path matcher and the kernel event system).

## Install with Composer

From the project root:

```bash
composer require drupal/url_restriction_by_role -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/url_restriction_by_role -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en url_restriction_by_role -y
```

Once enabled, grant the **Admin url restriction by role settings** permission to
the trusted role that will manage restrictions (People → Permissions), then head
to [Configuration](../configuration/index.md) to add your first rule.
