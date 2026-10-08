# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **File** module (`file`) — enabled in a standard install.
- The **Commerce License** module (`drupal/commerce_license`,
  `^2.0-alpha20 || ^3`) — Commerce File is built on top of it, and it in turn
  requires **Drupal Commerce**. Composer pulls these in.
- A working **private file system**. Because the files you sell should not be
  publicly accessible, the file field defaults to Drupal's **private** file
  scheme — so you must have the private file path configured in your Drupal
  settings.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_file -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Commerce License
(and Commerce itself) and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_file -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_file -y
```

Drupal enables the Commerce License and File dependencies at the same time. There
are no submodules.

## Grant the permission

Commerce File adds one permission, **Bypass license control** — it lets its
holder download any licensable file without a license and skips download limits
and logging. It is marked restricted; grant it only to trusted staff. The core
Commerce License permission **Administer commerce_license** behaves the same way
and also gates the settings form.

## Next step

Configure a product variation type to sell files — see
[Configuration](../configuration/index.md).
