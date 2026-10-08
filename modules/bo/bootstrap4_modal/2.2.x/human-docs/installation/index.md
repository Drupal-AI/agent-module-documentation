# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Bootstrap 4-based theme** (or Bootstrap 4's CSS/JS added some other way).
  The module styles the dialog but does **not** bundle Bootstrap itself, so
  without Bootstrap present the modals will not look or behave as intended.

There are no module dependencies, no PHP version requirement, and no third-party
Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap4_modal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bootstrap4_modal -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bootstrap4_modal -y
```

That's all it takes. The module's dialog libraries are attached to every page
automatically, so you can immediately start opening links in Bootstrap 4 modals —
see [the index page](../index.md) for the `use-ajax` markup. There is no
configuration form.

There are no submodules. If you want entity browsers to open in a Bootstrap 4
modal, also enable Drupal's **Entity Browser** module (`entity_browser`) and pick
the *Bootstrap 4 Modal* display on the browser's edit form; the details are in the
[`agent/`](../agent/start.md) docs.
