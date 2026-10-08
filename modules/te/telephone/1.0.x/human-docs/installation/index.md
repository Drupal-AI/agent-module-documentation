# Installation

## Requirements

- **Drupal 11.4 or newer, or Drupal 12** (`core_version_requirement:
  ^11.4 || ^12`). It installs *only* on Drupal 11.4+, because that is where core
  stopped shipping the Telephone module. On Drupal 11.3 and earlier, use the
  identical module that is still part of core instead — you do not need this
  project there.
- Core's **Field** module (`field`), part of the standard install and enabled
  automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/telephone -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/telephone -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en telephone -y
```

Once enabled, **Telephone** becomes available as a field type in the *Add field*
UI. See [How to use it](../index.md#how-to-use-it) in the overview.

## Upgrading from core Telephone

If you are moving a site past Drupal 11.4 and it previously used core's
Telephone module, there is nothing to migrate. The field type, widget, and
formatter ids are identical to core's, so once you `composer require
drupal/telephone` your existing `field.storage.*` and `field.field.*`
configuration and display settings keep working exactly as before.
