# Installation

## Requirements

- **PHP 8** or newer (`php: ^8`).
- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **JSON:API** module (`jsonapi`) enabled — this is the module's one
  dependency, and Drupal will enable it as a dependency for you.

There are no third-party Composer libraries to install. (The bundled examples
reference `drupal/consumer_image_styles` as a dev-only dependency, but you do not
need it for normal use.)

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_hypermedia -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/jsonapi_hypermedia -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_hypermedia -y
```

If JSON:API is not already on, Drupal enables it automatically as a dependency.

Enabling the module has **no immediate visible effect**: it adds no links until at
least one `LinkProvider` plugin is present. To see it in action, either write your
own provider (see [the overview](../index.md#how-to-use-it)) or adapt one of the
worked examples from the module's `examples/` directory. After adding or changing a
plugin, rebuild caches:

```bash
drush cr
```
