# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- The **Webform** module (`webform`) — this is a required dependency. Composer will
  pull it in when you install with `-W`, and Drupal will enable it as a dependency.

You will also need SharePoint / Microsoft app credentials (client ID and secret, or
a token) to configure the connection. Keep those in a secret store such as an
environment variable — not in exported config or version control.

## Install with Composer

From the project root:

```bash
composer require drupal/sharepoint_connector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the required Webform module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sharepoint_connector -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sharepoint_connector -y
```

This also enables Webform if it is not already on. After enabling, configure the
SharePoint connection with your app credentials (stored as secrets) so Drupal can
send data to SharePoint over HTTPS.
