# Installation

## Requirements

Dynamic Path Rewrites is lightweight and has no third‑party requirements:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No additional module dependencies.
- No external Composer or JavaScript library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/dynamic_path_aliases -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dynamic_path_aliases -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dynamic_path_aliases -y
```

## Verify it worked

Log in as an administrator and go to
**Configuration → Search and metadata → URL aliases → Rewrite**
(`/admin/config/search/path/rewrite`). You should see the **Path rewrites**
listing page with an *Add path rewrite* button. From here, follow
[Configuration](../configuration/index.md) to create your first rewrite.
