# Installation

## Requirements

- **Drupal 10 or 11** (the release requires `drupal/core: ^10 || ^11`).
- The **Address** module (`drupal/address`, `^1.0 || ^2.0`) enabled — the formatter
  only applies to fields of type `address`, so you need Address installed and at least
  one address field to format.

There are no third-party Composer libraries to install beyond what Address itself
pulls in.

## Install with Composer

From the project root:

```bash
composer require drupal/address_display -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Address module if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/address_display -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en address_display -y
```

If the Address module is not already enabled, Drupal enables it as a dependency.

Once enabled, the **Address Display** format becomes available on the **Manage
display** page of any bundle that has an address field. See
[the overview](../index.md#how-to-use-it) for how to select and configure it.
