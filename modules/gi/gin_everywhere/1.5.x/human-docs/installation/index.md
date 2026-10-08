# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- The **Gin** admin theme (`drupal/gin` `^3.0 || ^4.0 || ^5.0`) installed. This is
  a hard requirement: the module's install-time check **blocks installation** if
  the Gin theme isn't present, and its effects only appear while Gin (or a Gin
  sub-theme) is your active admin theme.

There are no third-party PHP library requirements.

## Install with Composer

If you don't already have Gin, install both together from the project root:

```bash
composer require drupal/gin drupal/gin_everywhere -W
```

(If Gin is already installed, `composer require drupal/gin_everywhere -W` is
enough.) The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gin drupal/gin_everywhere -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Set Gin as your admin theme

If you haven't already, install the Gin theme and set it as the administration
theme at **Appearance** (`/admin/appearance`) — or via Drush:

```bash
drush theme:enable gin -y
drush config:set system.theme admin gin -y
```

## Enable the module

```bash
drush en gin_everywhere -y
```

There are no submodules and **no configuration step** — enabling the module is the
whole setup. Open any content entity's add/edit form (a term, media item, user,
or custom entity) and it now uses Gin's content-form layout. If you don't see the
change, confirm Gin is your active admin theme.
