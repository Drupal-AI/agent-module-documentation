# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 7.4 or newer** (PHP 8.1+ is needed if you want to use the `enum`
  verifier type).
- The **`adaddinsane/param_verify`** package and its dependencies — these are
  fetched automatically by Composer when you require the module, since it exists
  to provide the glue to that library.

## Install with Composer

This module must be installed with Composer so that the underlying library is
pulled in — installing it any other way will not fetch the package it depends on.
From the project root:

```bash
composer require drupal/param_verify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`adaddinsane/param_verify` package and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/param_verify -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en param_verify -y
```

## Permissions

This module defines a permission. If you rely on it, review it at **People →
Permissions** (`/admin/people/permissions`) and grant it to the appropriate roles.
For most sites the module is simply a code dependency and needs no further
attention.

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`). There is no admin
page to visit — the module is working once it is enabled and the
`adaddinsane/param_verify` package is present in your `vendor/` directory, ready to
be used from your custom code.
