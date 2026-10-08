# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **`guzzlehttp/guzzle`** HTTP library (`^6 || ^7`), installed automatically
  when you install the module with Composer.
- An account at **e‑va.io** with an **Access Key** — required before validation
  will work.

There are no other Drupal module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/email_validator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Guzzle library
and update any shared dependencies as needed.

> **Note on versions:** `drupal/email_validator` ships both a 1.0.x and this
> 3.0.x line. Composer resolves the version that matches your Drupal core and any
> constraint in your `composer.json`. Set the constraint to `^3.0` if you want the
> release documented here.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/email_validator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en email_validator -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → System → EVA - Email
Validator** (`/admin/config/system/email-validator`). If the settings form loads,
the module and Guzzle are installed. Continue with
[Configuration](../configuration/index.md) to enter your Access Key and choose
which forms to validate.
