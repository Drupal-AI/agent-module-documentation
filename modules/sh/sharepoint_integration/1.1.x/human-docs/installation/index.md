# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).

There are no dependent contrib modules, no third-party Composer packages, and no PHP
library requirements listed. Before the connection is useful, you will need a
SharePoint / Azure app registration providing a client ID and secret — keep those in
a secret store, never in committed config.

## Install with Composer

From the project root:

```bash
composer require drupal/sharepoint_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sharepoint_integration -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sharepoint_integration -y
```

## Next step

Once enabled, set up the SharePoint connection on the module's configuration form.
See [Configuration](../configuration/index.md).
