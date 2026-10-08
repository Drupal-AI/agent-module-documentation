# Installation

## Requirements

Extra Image Field Classes is intentionally minimal. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Image** module (`image`) enabled — this is the only dependency, and it
  is part of core.
- Core's **Field UI** module if you want to select and configure the formatter
  through the admin UI (Manage Display). It is not required to render an already
  configured field.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/extra_image_field_classes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/extra_image_field_classes -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en extra_image_field_classes -y
```

That is all it takes. There is no configuration form to visit. Once enabled, the
**Extra Image Field Classes** format becomes available on any image field under
Manage Display — see the [overview](../index.md) for how to select it and add your
classes.
