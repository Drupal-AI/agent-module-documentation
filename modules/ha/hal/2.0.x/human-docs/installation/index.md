# Installation

## Requirements

HAL is lightweight and depends only on Drupal core modules:

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Serialization** module (`serialization`) — this is the one hard
  dependency, and Drupal enables it automatically when you turn on HAL.
- In practice you'll also want core's **REST** module (`rest`) enabled, since
  HAL exists to give REST resources and Views REST exports the `hal_json`
  format. It is not a strict dependency, but on its own HAL has nothing to feed.

There are no third‑party Composer libraries or special PHP extensions required.

## Install with Composer

From the project root:

```bash
composer require drupal/hal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/hal -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hal -y
```

Drupal enables core's **Serialization** module automatically as a dependency.
If you haven't already, enable REST too so there's something to serialize:

```bash
drush en rest -y
```

That's all it takes — the `hal_json` format is now available to the serializer,
to any REST resource, and to Views REST export displays. There is no settings
form to fill in.

## Submodules

HAL ships no submodules.
