# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **Metatag** module (`metatag`) — this module reads and writes Metatag fields,
  so it is essential.
- The **Token** module (`token`).

Both dependencies are declared, so Composer pulls them in for you. The module
supports both the Metatag v1 and v2 encoding APIs.

## Install with Composer

From the project root:

```bash
composer require drupal/metatag_import_export_csv -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Metatag and Token.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/metatag_import_export_csv -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en metatag_import_export_csv -y
```

There are no submodules. After enabling, grant the export and/or import permissions
to the right roles, then use the two screens under **Configuration → Search and
metadata → Metatag** — see [Configuration](../configuration/index.md).
