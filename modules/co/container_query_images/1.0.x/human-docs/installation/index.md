# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2||^11`).
- Core's **Image** (`image`), **Responsive Image** (`responsive_image`), and
  **Breakpoint** (`breakpoint`) modules — all part of core, enabled automatically as
  dependencies.
- A **modern browser** on the visitor side, since the feature relies on CSS
  container queries.

There are no additional PHP libraries or third‑party Composer requirements. This
project is covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/container_query_images -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/container_query_images -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en container_query_images -y
```

This enables the core Responsive Image and Breakpoint modules too if they aren't
already on.

## Verify it worked

Follow the "How to use it" steps in the [overview](../index.md): define a
breakpoint group whose name contains `container`, build a Responsive Image Style on
it at `/admin/config/media/responsive-image-style`, and apply that style to an image
field's display. Then view the same component in a narrow and a wide region and
confirm the browser loads different image sizes based on the container width.
