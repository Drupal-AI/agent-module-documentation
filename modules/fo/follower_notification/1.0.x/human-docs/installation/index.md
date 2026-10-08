# Installation

## Requirements

Follower Notification needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **Flag** module (`flag`) and the **Flag Follower** module (`flag_follower`),
  both required dependencies — they provide the "follow" relationship this module
  builds on.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/follower_notification -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Flag, Flag
Follower, and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/follower_notification -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **machine name**, which is plural — `follower_notifications` —
even though the project/directory name is singular:

```bash
drush en follower_notifications -y
```

Enabling the module creates its dedicated `notifications` database table, where it
stores each notification record.

## Verify it worked

1. Confirm Flag Follower is set up so users can follow one another.
2. Go to **Configuration → Follower Notifications → Admin settings**
   (`/admin/config/follower_notifications/adminsettings`) — you should see the
   settings form. See [Configuration](../configuration/index.md).
3. As a test, have one user follow another, then publish content as the followed
   user, and confirm the follower receives a notification.
