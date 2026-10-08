# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1`).
- Core's **Options** (`options`), **User** (`user`) and **Views** (`views`)
  modules.
- The contributed **Entity** (`entity`) module.

There are no PHP library requirements. Composer will pull in the Entity module
with the `-W` flag below.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_segment -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update
dependencies such as the Entity module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_segment -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_segment -y
```

## Verify it worked

Go to **Structure → Segment types** (`/admin/structure/segment-type`). If the
segment types listing loads, the module is installed. From there, continue to
[Configuration](../configuration/index.md) to define your first segment type and
build a segment.
