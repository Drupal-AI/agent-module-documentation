# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`). Fully compatible
  with Drupal 11 and PHP 8.4.
- Core's **Field** module (`field`) — enabled on almost every site already, and
  pulled in automatically as a dependency.
- The **`kwn/number-to-words`** PHP library, which does the actual conversion.
  When you install the module from Drupal.org with Composer, this library is
  brought in for you.

## Install with Composer

From the project root:

```bash
composer require drupal/numbertoword -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and install the
`kwn/number-to-words` library and any other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/numbertoword -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

If you are placing the module manually for local development instead of installing
the Drupal.org package, install the library yourself with
`composer require kwn/number-to-words`.

## Enable the module

```bash
drush en numbertoword -y
```

## Verify it worked

Go to a content type's **Manage display**, pick a numeric field, and confirm
**Number to Word** appears as a format option. If it does not, clear caches with
`drush cr`. If displaying the field raises a "NumberToWords library not found"
error, run `composer require kwn/number-to-words` to install the missing library.
