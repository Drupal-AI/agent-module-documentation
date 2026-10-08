# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- Core's **Taxonomy** module (`taxonomy`), which supplies the terms the global
  filter is built on. Drupal enables it automatically as a dependency when you turn
  on Simple Global Filter.

There are no third‑party Composer packages or PHP libraries to install. Note that
the project is currently in "maintenance fixes only" mode and seeking a new
maintainer.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_global_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_global_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_global_filter -y
```

## Verify it worked

Once enabled, you can create a global filter and expose it — for example by placing
the global‑filter block through **Structure → Block layout**. Set a value and browse
between pages; the selection should persist for the rest of your session, and any
block or View you have wired to it should respond accordingly.
