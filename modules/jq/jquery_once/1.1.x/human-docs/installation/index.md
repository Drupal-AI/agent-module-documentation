# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
  It is most useful on Drupal 10 and 11, where core no longer ships
  `jquery.once`.
- No other contrib modules, Composer libraries or PHP extensions are required —
  the jQuery and jquery-once files are bundled with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_once -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/jquery_once -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jquery_once -y
drush cr
```

The cache rebuild matters: Drupal caches library definitions, so the restored
`core/jquery.once` only takes effect after caches are cleared. There is no
configuration form and no permission to grant.

## Verify it worked

Check that the restored libraries report their bundled versions:

```bash
drush php:eval '
  $d = \Drupal::service("library.discovery");
  print $d->getLibraryByName("core", "jquery")["version"] . "\n";        # 3.7.1
  print $d->getLibraryByName("core", "jquery.once")["version"] . "\n";   # 2.2.3
'
```

If both versions print, legacy `$(...).once('id')` JavaScript on your site should
now work again. See the [overview](../index.md#how-to-use-it) for how to depend
on the library from your own code.
