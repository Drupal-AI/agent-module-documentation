# Installation

## Requirements

Views Show More Pager is self-contained. It needs:

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Views** module (`views`), which is part of standard Drupal and is
  enabled automatically as a dependency.
- No third-party Composer packages, PHP extensions, or JavaScript libraries. (The
  module ships its own small JavaScript for the AJAX "load more" behavior.)

## Install with Composer

From the project root:

```bash
composer require drupal/views_show_more -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_show_more -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_show_more -y
```

Enabling it makes the **Show more pager** available in the Views UI. There is no
settings page and no configuration step — you select and configure the pager per
view.

## Verify it worked

Edit any view at **Structure → Views**, open its **Pager** section, and confirm
that **Show more pager** appears in the list of pager types you can choose. See the
[how-to-use section on the overview page](../index.md#how-to-use-it) for what to do
next — and remember to turn on **Use AJAX** for the smoothest load-more experience.
