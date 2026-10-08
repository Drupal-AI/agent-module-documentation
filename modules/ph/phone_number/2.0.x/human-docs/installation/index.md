# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Field** module (`field`) enabled — part of the standard install.
- The **`giggsey/libphonenumber-for-php`** PHP library (`^8.0`) — this is what
  powers the validation and formatting. It is a required Composer dependency, so
  installing the module via Composer (rather than downloading it by hand) is
  essential: a manual download will leave the library missing and the field will
  not work.

## Install with Composer

From the project root:

```bash
composer require drupal/phone_number -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the
`giggsey/libphonenumber-for-php` library and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/phone_number -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en phone_number -y
```

## Optional submodule — SMS verification and two‑factor

The module ships a submodule, **`sms_phone_number`**, that adds SMS verification
and two‑factor authentication on top of the phone field. Enable it only if you
need those features (it has its own additional requirements around SMS delivery):

```bash
drush en sms_phone_number -y
```

## Next steps

There is no settings page. Add a **Phone Number** field to a content type (or any
entity) from its **Manage fields** screen, then configure the field, widget, and
formatter as described in [Configuration](../configuration/index.md).
