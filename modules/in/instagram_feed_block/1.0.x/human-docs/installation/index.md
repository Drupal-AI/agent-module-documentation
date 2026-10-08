# Installation

## Requirements

- **Drupal 10.1+, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- The **Key** module (`key`) — this module depends on it to store the access
  token securely. Composer pulls it in automatically.
- On the Instagram/Meta side: an **Instagram Business or Creator account**, a
  **Facebook Developer app**, **Instagram Graph API access**, and a **long-lived
  access token**.

## Install with Composer

From the project root:

```bash
composer require drupal/instagram_feed_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Key module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/instagram_feed_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en instagram_feed_block -y
```

If the Key module is not already enabled, Drupal enables it as a dependency; you
can also enable it explicitly with `drush en key -y`.

## Verify it worked

Confirm both modules are enabled at **Extend** (`/admin/modules`). Then continue
to [Configuration](../configuration/index.md) to store your access token, enter
your account ID, and place a feed block.
