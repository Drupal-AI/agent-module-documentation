# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (a dependency, enabled on standard installs).
- No third-party Composer libraries — the jsTree JavaScript library ships bundled
  with the module, so there's nothing extra to download.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_tree -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_reference_tree -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_tree -y
```

There are no submodules.

## Next step

The widget doesn't do anything until you assign it to an entity reference field.
Head to [Configuration](../configuration/index.md) to enable it on a field and
tune its options.
