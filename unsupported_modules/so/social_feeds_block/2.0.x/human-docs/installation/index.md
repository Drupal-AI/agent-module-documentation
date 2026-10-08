# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.2** or newer.
- API credentials (app id/secret, tokens, API keys) for each social network you
  intend to display — you get these from each provider's developer console. This
  is the substantial part of setup; see [Configuration](../configuration/index.md).

The module has no dependent modules and no third-party Composer or PHP library
requirements of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/social_feeds_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_feeds_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_feeds_block -y
```

## Verify it worked

After enabling, go to **People → Permissions** and grant **administer
social_feeds_block** to trusted administrators only (it is a restricted
permission). Then visit **Configuration → Web services → Social Feeds Block**
(`/admin/config/services/social-feeds-block`) — you should see a menu linking to
each network's settings form. Nothing will display until you configure at least
one network and place its block.
