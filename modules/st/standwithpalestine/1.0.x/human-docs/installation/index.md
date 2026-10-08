# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`).
- No third-party Composer packages, PHP libraries, or contrib module
  dependencies. Note that the widget itself loads JavaScript from the external
  standwithpalestine.org project at runtime.

## Install with Composer

From the project root:

```bash
composer require drupal/standwithpalestine -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/standwithpalestine -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en standwithpalestine -y
```

That is all it takes. The widget's JavaScript is now added to every page and the
solidarity banner displays site-wide — there is no configuration step.

## Verify it worked

Visit any page on your site. The Stand With Palestine widget/banner should appear.
If it does not, clear caches (`drush cr`) and confirm your site can load the
external widget script.
