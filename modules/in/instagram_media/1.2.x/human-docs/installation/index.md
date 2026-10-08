# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block** module (`block`), which Drupal enables by default.
- On the Instagram/Meta side: an account with **Instagram Graph API** access and a
  **long-lived access token** (business or creator account). For automatic token
  refresh you'll also need your app's ID and secret from
  <https://developers.facebook.com>.
- **Optional:** the core **Responsive Image** module if you want to use responsive
  image styles for the feed.

## Install with Composer

From the project root:

```bash
composer require drupal/instagram_media -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/instagram_media -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en instagram_media -y
```

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`), then go to
**Structure → Block layout** and check that an **Instagram Media** block is
available to place. Continue to [Configuration](../configuration/index.md) to add
your token and set the display options.
