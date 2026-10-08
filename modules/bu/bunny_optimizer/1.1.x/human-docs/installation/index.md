# Installation

## Requirements

- **Drupal 9.3+, 10, or 11** (`core_version_requirement: ^9.3||^10||^11`).
- **PHP 7.4** or newer (`php_requirement: 7.4`).
- Core's **File** (`file`) and **Image** (`image`) modules.
- The **File Metadata Manager** module (`file_mdm`), which Composer pulls in.
- A **Bunny.net account** with a pull zone set up for your site's images.

## Install with Composer

From the project root:

```bash
composer require drupal/bunny_optimizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and brings in the File Metadata Manager dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bunny_optimizer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bunny_optimizer -y
```

Drupal enables the `file_mdm` dependency (and core File/Image) at the same time.

## Next step

Continue to [Configuration](../configuration/index.md) to connect the module to
your Bunny.net pull zone and handle credentials safely.
