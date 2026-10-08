# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Media** module (`media`) — a required dependency, enabled
  automatically.
- A working **cron** on your site so the expiry sweep runs regularly (or you can
  trigger it manually with Drush — see below).
- No third-party Composer or PHP library requirements. GraphQL support is
  optional and only relevant on decoupled sites.

You'll also need at least one **datetime field** on each media type you want to
expire — the module uses it as the expiry trigger. Add one under the media type's
*Manage fields* if it doesn't already have a suitable field.

## Install with Composer

From the project root:

```bash
composer require drupal/media_expire -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_expire -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_expire -y
```

There is nothing to configure globally — expiry is switched on per media type.
Continue to [Configuration](../configuration/index.md).
