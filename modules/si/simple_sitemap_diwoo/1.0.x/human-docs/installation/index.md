# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Simple XML Sitemap** module (`simple_sitemap`) — required; this module
  extends it.
- Core **Token** (`token`) — required, and used for dynamic metadata values.
- The core **Media** module is expected too (enable it if it isn't already), since
  the sitemap indexes media files.

No external libraries or APIs are needed.

## Install with Composer

If you don't already have Simple XML Sitemap and Token, Composer will pull them in
as dependencies. From the project root:

```bash
composer require drupal/simple_sitemap_diwoo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (The Composer package name, `drupal/simple_sitemap_diwoo`,
matches the module's machine name.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_sitemap_diwoo -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_sitemap_diwoo -y
```

If you use the Media module for your files, enable that too (`drush en media -y`)
if it isn't already on.

## Next steps

Enabling the module is only the start — DiWoo needs a field, a sitemap type, and a
variant before it produces output. Continue with
[Configuration](../configuration/index.md).
