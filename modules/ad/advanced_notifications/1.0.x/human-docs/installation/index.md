# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Drupal core's **REST** (`rest`), **Serialization** (`serialization`), and
  **User** (`user`) modules. Drupal enables these automatically as dependencies
  when you turn on Advanced Notifications.
- A pair of **VAPID keys** for web push. You generate these once and enter them
  in the module's settings (see [Configuration](../configuration/index.md)).
- Web push requires HTTPS — browsers will not allow subscriptions on an insecure
  connection.

## Install with Composer

From the project root:

```bash
composer require drupal/advanced_notifications -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/advanced_notifications -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_notifications -y
```

After enabling, go to [Configuration](../configuration/index.md) to add your VAPID
keys and set up who may manage settings, subscriptions, and campaigns.
