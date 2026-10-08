# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** module (`image`) enabled — this is the only dependency, and
  Drupal enables it automatically when you turn on this module.
- **Drush**, since the module's only feature is a Drush command.

There are no third-party Composer or PHP library requirements for the base
module.

## Install with Composer

From the project root:

```bash
composer require drupal/image_styles_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/image_styles_generator -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_styles_generator -y
```

The `drush image:derive:multiple` command is available immediately — see the
[overview](../index.md#how-to-use-it) for how to run it.

## Optional: WebP copies

The bundled **image_styles_generator_webp** submodule makes the warmer also emit
a WebP copy of each derivative. It relies on the separate
[`webp`](https://www.drupal.org/project/webp) module, so install that first:

```bash
composer require drupal/webp -W
drush en webp image_styles_generator_webp -y
```

Once enabled, the same `drush image:derive:multiple` command transparently writes
WebP copies alongside the normal derivatives — you do not run a different command.
