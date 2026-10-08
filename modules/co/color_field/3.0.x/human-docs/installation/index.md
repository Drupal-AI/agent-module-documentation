# Installation

## Requirements

Color Field is light on requirements:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** module (`field`) enabled — this is the only dependency, and it is part of Drupal's standard install, so it is almost always already on.

There are no PHP extension or third‑party Composer library requirements. Two modules are *suggested* but never required: **Token** (exposes the HEX/RGB color tokens) and **Feeds** (adds a target for importing color values). The Spectrum, Box, and Grid picker widgets bundle their own JavaScript; some setups expect those library files under `/libraries/…`.

## Install with Composer

From the project root:

```bash
composer require drupal/color_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/color_field -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en color_field -y
```

That's all it takes — Color Field ships no submodules, so there is nothing else to turn on. Once enabled, the new **Color** field type is immediately available when you add a field to any content type or other fieldable entity (see the [How to use it](../index.md#how-to-use-it) section for the next steps).
