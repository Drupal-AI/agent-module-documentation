# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core modules, enabled as dependencies: **Block**, **Content Moderation**,
  **Field**, **Link**, **Node**, **Options**, **User**, **Views** and **Workflows**.
- The contributed **Condition Field** module (`condition_field`) — used for the
  banner's visibility conditions.

There are no additional third-party PHP library requirements. This module is part of
the LocalGov Drupal ecosystem and is designed for that context.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_alert_banner -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Condition Field and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_alert_banner -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_alert_banner -y
drush cr
```

Enabling the module brings in its core and contrib dependencies and installs a set
of ready-made configuration:

| Config it installs | Purpose |
|--------------------|---------|
| The default banner **bundle** (`localgov_alert_banner`) | The out-of-the-box banner type |
| Fields: short description, link, type of alert, visibility | Banner text, call-to-action, severity (drives ordering), and where it shows |
| The `localgov_alert_banners` **workflow** | Moderation states for draft/published |
| The `emergency_publisher` **role** | A ready-made role for the emergency comms team |
| The admin **view** at `/admin/content/alert-banners` | The banner listing |

After enabling, continue to [Configuration](../configuration/index.md) to create a
banner, place the block, and set up permissions.
