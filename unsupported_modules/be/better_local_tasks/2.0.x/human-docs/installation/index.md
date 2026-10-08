# Installation

## Requirements

Better Local Tasks is lightweight and self‑contained. It needs:

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).

There are no contrib dependencies, no third‑party Composer or PHP libraries, and
no JavaScript.

## Install with Composer

The Drupal.org project short name is **betterlt**, so the Composer package is:

```bash
composer require drupal/betterlt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (The module's machine name is `better_local_tasks`, which
is what you enable below.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/betterlt -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en better_local_tasks -y
```

That is all it takes — there are no submodules and no required configuration. The
restyled tabs appear immediately on front‑end content pages for users who can see
contextual links.
