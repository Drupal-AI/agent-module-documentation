# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Telephone** module (`telephone`) — this is a declared dependency and
  Drupal enables it automatically. The module extends core's telephone field; it
  does not add a new field type.
- The **`giggsey/libphonenumber-for-php`** library (`^8.12 || ^9.0`), the PHP port
  of Google's libphonenumber. Composer installs this for you as part of the
  command below — do not download it by hand.

## Install with Composer

From the project root:

```bash
composer require drupal/telephone_advanced -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it is what pulls in the libphonenumber library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/telephone_advanced -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en telephone_advanced -y
```

Enabling the module makes its widget, formatter and validation available, but it
does not change any of your existing fields. Continue with
[Configuration](../configuration/index.md) to switch a telephone field over to
them.

## Verify it worked

Add or edit a **telephone** field on a content type. On the field's **Manage form
display** and **Manage display** screens you should now see the Telephone Advanced
widget and formatter available as options.
