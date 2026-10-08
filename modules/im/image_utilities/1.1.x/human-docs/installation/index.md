# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Image** module (`image`) — enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements, and the module
adds no permissions.

## Install with Composer

From the project root:

```bash
composer require drupal/image_utilities -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_utilities -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_utilities -y
```

## Verify it worked

The module has no UI to check. Confirm it's enabled (**Extend**, or `drush
pm:list | grep image_utilities`), then try the `image_style` Twig filter in a
template — for example `{{ content.field_image|image_style('large') }}`. See the
[manual setup guide](../index.md) for the full list of helpers.
