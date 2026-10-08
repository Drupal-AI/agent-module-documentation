# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No module dependencies, no third‑party Composer packages, and no external
  library requirements — the Bootstrap 5 CSS and JS are bundled inside the
  module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/drupal_bootstrap5 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drupal_bootstrap5 -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The machine name declared in the module's info file is `DrupalBootstrap5` (note
the capitalisation), so enable it with:

```bash
drush en DrupalBootstrap5 -y
```

The Bootstrap 5 library is attached to every page immediately. There is no
configuration step.

## Verify it worked

Load any page and view the source (or your browser's network panel): you should
see the module's Bootstrap 5 CSS and JS files loaded from within the module's
`css/` and `js/` directories. Add a Bootstrap class such as `btn btn-primary` to
some markup in your theme or a block and confirm it picks up Bootstrap styling.

> **Heads up:** If your theme already ships Bootstrap, disable one source or the
> other — loading Bootstrap twice can cause conflicting styles and duplicated JS
> behavior. Disabling this module removes the library from all pages.
