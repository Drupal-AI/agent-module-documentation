# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).

There are no module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/extra_pagination -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/extra_pagination -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en extra_pagination -y
```

That's all — there is no setup required. The extra pager items appear as soon as
the module is enabled.

## Verify it worked

Open a paged listing on your site that has enough results to span many pages (a
view, a taxonomy term page, or any list with a pager). You should see additional
page links between the usual nearby links and the final page. If your listing has
only a handful of pages, there may be nothing extra to show — that's expected.
Check that the pager still looks right in your theme.
