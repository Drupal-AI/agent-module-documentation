# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** module (`media`).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_standalone_url_permission -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_standalone_url_permission -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_standalone_url_permission -y
```

## Verify it worked

Once enabled, the module immediately applies its access gate to the `/media/{id}`
canonical route. Confirm this by visiting a media entity's standalone page as an
anonymous user (or a role without the new permission) — you should get an
**Access denied** rather than the media page. Then grant **access standalone media
url** to the roles that should reach it, as described in
[Configuration](../configuration/index.md).
