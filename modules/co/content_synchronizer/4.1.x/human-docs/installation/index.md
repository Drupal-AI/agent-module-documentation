# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 7.0 or newer** (`php: >=7.0`).
- Core's **File** module (`file`) enabled — Drupal enables it as a dependency.
- The **`cocur/slugify`** PHP library (version 2 or newer). Composer installs this
  automatically when you require the module, so there is nothing extra to do as
  long as you install via Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/content_synchronizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it also pulls in the required `cocur/slugify`
library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/content_synchronizer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_synchronizer -y
```

There are **no submodules**. Because this tool moves content *between*
environments, install and enable it on **both** the source and destination sites.

Next, grant the relevant permissions and start building an Export entity — see
[Configuration](../configuration/index.md).
