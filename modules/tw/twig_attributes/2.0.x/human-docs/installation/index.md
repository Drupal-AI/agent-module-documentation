# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

That's it — there are no dependent modules, and no third‑party Composer or PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/twig_attributes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/twig_attributes -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en twig_attributes -y
```

There's nothing to configure and no permissions to grant. As soon as the module is
enabled, the `add_attr` / `with_attr` Twig filter is available in your templates —
see [the main page](../index.md#how-to-use-it) for the filter's arguments and
examples.

> **Tip:** clear the theme/render cache (`drush cr`) after enabling, so the
> augmented core templates (`image_formatter`, `responsive_image_formatter`,
> `file_link`) pick up the new attribute variables.
