# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The contributed **Message** module, which provides the notification messages
  this module lets people subscribe to. Install and configure Message first.
- This is an **alpha** release (`1.0.0-alpha9`) — test it on a non-production
  copy before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/advanced_message_subscription -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/advanced_message_subscription -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_message_subscription -y
```

After enabling, review **People → Permissions** to grant the subscription
permission to the roles that should manage their own notification preferences.
