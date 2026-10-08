# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no other module, Composer, or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/prod_no_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/prod_no_redirect -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en prod_no_redirect -y
```

## Required: edit your front controller (`index.php`)

Enabling the module is **not sufficient on its own**. The protection works by
substituting the module's kernel for Drupal's default one at the very start of the
request, before the installer redirect can fire. You must edit your site's front
controller (`index.php` in the web root) so it boots the module's
`ProdNoRedirectKernel` class instead of the standard `DrupalKernel`.

Refer to the module's project page for the exact example code for your Drupal
version, and apply the equivalent change to your `index.php`.

## Also: stop Composer from overwriting `index.php`

Because `index.php` is normally a scaffolded file, a future `composer update`
would overwrite your edit and silently undo the protection. Configure **Drupal
Scaffold** to leave `index.php` alone (exclude it from the files Scaffold
overwrites) so your change survives updates. This is set in the
`drupal/core-composer-scaffold` configuration of your project's root
`composer.json`.

## Verify it worked

On a **non-production, disposable** copy of the site, simulate the failure the
module guards against (for example an empty/uninitialised database) and request
the front page. With the module enabled and `index.php` pointed at
`ProdNoRedirectKernel`, the site should **not** redirect to `install.php`. Never
run this test against a real production database.
