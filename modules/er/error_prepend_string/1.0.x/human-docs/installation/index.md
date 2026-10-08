# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies.
- **Access to your PHP configuration** — you need to be able to set the
  `error_prepend_string` / `error_append_string` ini directives via `php.ini`,
  `.htaccess`, or a `settings.php` `ini_set()` call. (This is easy under DDEV.)
- *Optional:* if you also want to cover fatal errors, `cweagans/composer-patches`
  to apply the relevant Drupal core patch.

## Install with Composer

From the project root:

```bash
composer require drupal/error_prepend_string -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/error_prepend_string -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en error_prepend_string -y
```

## Set the ini directives

The module has no settings form — set the strings in PHP configuration, for example
in `php.ini`:

```ini
error_prepend_string = "<style>/* your wrapper markup / CSS here */</style>"
error_append_string  = "<!-- appended footer markup -->"
```

## Verify it worked

Trigger an error from a thrown exception (in a non-production/development
environment) and confirm your prepend/append markup appears wrapped around the
response. Remember the caveats in the [overview](../index.md): fatal errors need a
core patch, and you should verify the wrapping scope before relying on it in
production.
