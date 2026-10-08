# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **Block** module (`block`) — enabled by default on a standard install; it
  is the only dependency and provides the block-layout system this module plugs
  into.

There are no third-party library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/go_back_history -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/go_back_history -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en go_back_history -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
block** in any region. The **Go back history block** should appear in the list.
Place it, save, then browse to a page and use the link — it should take you back to
the previous page you visited. See the [overview page](../index.md) for placement
tips and the caveat about visitors who arrive with no history.
