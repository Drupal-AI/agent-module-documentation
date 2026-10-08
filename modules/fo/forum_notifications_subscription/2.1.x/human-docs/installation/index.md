# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Forum** module (`forum`) enabled — this is the module's only dependency,
  and it is what provides the containers, forums, topics and comments that
  subscriptions are built on. Drupal will pull it in automatically when you enable
  Forum Notifications Subscription.
- A working outbound **email** setup on your site, since the whole point of the
  module is to send notification emails.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/forum_notifications_subscription -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/forum_notifications_subscription -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en forum_notifications_subscription -y
```

If core Forum is not already on, Drupal enables it at the same time.

## Verify it worked

Visit a forum topic as a logged‑in user — you should now see a
subscribe/unsubscribe control for the forum and for the topic. Post a reply from a
second account and confirm the subscriber receives a notification email. If nothing
arrives, check your site's mail configuration first, then review the
[Configuration](../configuration/index.md) page to confirm the notification
settings are saved.

> **Upgrading from 1.x?** Version 2.x changes how the Daily Digest works — instead
> of sending separate emails, it combines a user's daily activity into a single
> summarized email. After requiring 2.x, open the settings form, review the new
> fields, and save once to migrate your configuration.
