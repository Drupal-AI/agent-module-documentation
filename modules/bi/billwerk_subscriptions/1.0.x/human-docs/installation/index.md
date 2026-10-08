# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Locale** module (`locale`), enabled automatically as a dependency.
- A **Billwerk (reepay) account** with API access, so you can obtain the API key and
  configure the webhook.

There are no third-party Composer or PHP library requirements listed. Two modules are
*suggested* (optional) for debugging and auditing: `http_client_logger` (to trace the
outbound Billwerk API calls) and `entity_log` (to track account changes).

> **Note:** This release is a beta (`1.0.0-beta16`). Test it on a non-production
> environment before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/billwerk_subscriptions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/billwerk_subscriptions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en billwerk_subscriptions -y
```

Drupal enables the Locale dependency automatically. After enabling, continue to
[Configuration](../configuration/index.md) to enter your Billwerk credentials, map
plans to roles, and register the webhook.
