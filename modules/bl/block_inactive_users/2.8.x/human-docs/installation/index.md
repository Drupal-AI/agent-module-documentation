# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- A working **cron** — the automatic block/warn sweep runs on `hook_cron`, so the
  auto‑block feature only fires when cron runs (you can also trigger a sweep
  manually from the settings form).
- No third‑party Composer packages, PHP libraries or other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/block_inactive_users -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/block_inactive_users -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_inactive_users -y
```

There are **no submodules**. Once enabled, configure the module before relying on
it — see [Configuration](../configuration/index.md). Nothing is blocked until you
set an idle time and cron runs (or you press the "Disable inactive users" button).

## Permissions

The settings and Cancel Users forms require the core **Administer site
configuration** permission — grant that to any non‑admin role that needs access.
(The module also declares a restricted **Administer block_inactive_users
configuration** permission, but the routes are gated by the core permission
above.)

## Verify it worked

Visit **Configuration → People → Block Inactive Users**
(`/admin/config/people/block_inactive_users`) and confirm the settings form loads.
