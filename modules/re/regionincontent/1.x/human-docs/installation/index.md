# Installation

## Requirements

Region in Content needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A theme you can edit — the module exposes regions as variables, but **you print
  them in your node template**, so you need access to (usually a custom or sub-)
  theme's `node--full.html.twig`.

There are no other module, Composer, or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/regionincontent -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/regionincontent -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en regionincontent -y
```

## Verify it worked

Go to **Configuration → User interface → Region in Content**
(`/admin/config/user-interface/regionincontent`) and confirm the settings form
loads. Then follow [Configuration](../configuration/index.md) to list a region and
print it in your node template.
