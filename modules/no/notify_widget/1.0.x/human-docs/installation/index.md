# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other module dependencies, and no third‑party Composer or PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/notify_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/notify_widget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en notify_widget -y
```

## Place the block

Notifications are shown by a block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Add the **Notify Widget** block to a region — the header is the natural spot
   for a notifications icon.
3. In the block's visibility settings, restrict it to **authenticated users**
   (anonymous visitors have no personal notifications).

## Verify it worked

With the block placed, create a test notification from code (see the `send()`
example on the [overview page](../index.md)) addressed to your own user, then
reload the site. The notifications icon should show a red unread badge; clicking
the notification should follow its link and mark it read.

Next, review [Configuration](../configuration/index.md) to set the maximum number
of notifications and decide whether to use the module's bundled CSS.
