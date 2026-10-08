# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **`cocur/slugify`** PHP library (`^4.0`) — pulled in automatically by
  Composer via the module's own `composer.json`.

There are no Drupal module dependencies, permissions, or settings.

## Install with Composer

From the project root:

```bash
composer require drupal/twig_slugify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install `cocur/slugify` and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/twig_slugify -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en twig_slugify -y
```

That is all. The `slugify` Twig filter is now available in every template — see
[the overview](../index.md#how-to-use-it) for usage examples. There is no
configuration step.
