# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- No other modules, PHP libraries, or third-party Composer packages.

Note that this release is **not** covered by drupal.org's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/timeout_notification -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/timeout_notification -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en timeout_notification -y
```

## Grant the permission

The settings form is protected by the `configure_timeout_notification_settings`
permission. After enabling, go to **People → Permissions**, grant that permission to
your administrator role, and save — otherwise the settings form at
`/admin/config/timeout_notification` will be unreachable.

## Verify it worked

Log in as a user with the permission above and visit
`/admin/config/timeout_notification`. You should see the settings form where you can
set how many seconds in advance the expiry warning appears. Then, on a normal page,
stay idle long enough and confirm the warning/refresh notification appears before
the session would end.
