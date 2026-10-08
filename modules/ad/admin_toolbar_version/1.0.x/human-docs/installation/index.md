# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- The **Admin Toolbar Extra Tools** submodule (`admin_toolbar_tools`), which is
  part of the [Admin Toolbar](https://www.drupal.org/project/admin_toolbar)
  project — the version entry attaches to its tools menu. Composer pulls Admin
  Toolbar in automatically as a dependency; you enable the `admin_toolbar_tools`
  submodule yourself (see below).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/admin_toolbar_version -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including pulling in Admin Toolbar — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/admin_toolbar_version -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the Extra Tools submodule and this module together:

```bash
drush en admin_toolbar_tools admin_toolbar_version -y
```

Once enabled, the version appears under the Admin Toolbar tools menu. To adjust
display options, visit **Configuration → User interface → Admin Toolbar Version**
(requires the *Administer site configuration* permission).
