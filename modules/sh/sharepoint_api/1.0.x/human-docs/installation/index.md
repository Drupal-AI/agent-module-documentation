# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).

There are no dependent contrib modules, no third-party Composer packages, and no PHP
library requirements listed. What you *will* need before the client is useful is a
SharePoint / Microsoft 365 app registration providing the client id, client secret,
and tenant — keep those in an environment variable, never in committed config.

## Install with Composer

From the project root:

```bash
composer require drupal/sharepoint_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sharepoint_api -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sharepoint_api -y
```

Because this is a connectivity layer, enabling it usually goes hand in hand with
enabling a module that uses it (such as `sharepoint_file_download`) and with
providing your SharePoint app credentials through a securely stored environment
variable.
