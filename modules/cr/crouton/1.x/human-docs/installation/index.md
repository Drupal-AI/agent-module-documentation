# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).

There are no module or third-party library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/crouton -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/crouton -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en crouton -y
```

Once enabled, Crouton doesn't change breadcrumbs until you select a source menu — see
[Configuration](../configuration/index.md). If no menu is selected, breadcrumbs fall
through to the next applicable breadcrumb builder (effectively leaving core's
behavior in place).

## Verify it worked

Log in as an administrator, go to **Extend**, find Crouton, and click its
**Configure** link. Choose a breadcrumb menu, save, then visit a page whose location
is defined in that menu — its breadcrumb trail should now follow the menu hierarchy.
