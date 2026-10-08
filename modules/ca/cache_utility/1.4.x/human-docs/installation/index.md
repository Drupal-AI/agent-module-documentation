# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules, third-party Composer packages, or PHP libraries are required.
- To use the OPcache and APCu operations, those PHP extensions must be present in
  your environment.

## Install with Composer

From the project root:

```bash
composer require drupal/cache_utility -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cache_utility -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cache_utility -y
```

After enabling, set an access key on the settings form before using the endpoints —
see [Configuration](../configuration/index.md). Until a key is set, the endpoints
reject all callers, so the module is safe by default but does nothing useful yet.

## Optional submodule — Admin Toolbar integration

Cache Utility ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Cache Utility Admin Toolbar** | `cache_utility_admin_toolbar` | Surfaces the cache-clear actions in the administration toolbar so you can trigger them from the UI. |

Enable it only if you want the toolbar buttons:

```bash
drush en cache_utility_admin_toolbar -y
```

## Grant the permission

Reaching the settings form requires the **Administer cache utility configuration**
permission (**People → Permissions**). Grant it only to trusted administrators — that
permission controls who can see and set the shared access key.
