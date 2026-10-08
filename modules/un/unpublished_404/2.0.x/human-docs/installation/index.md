# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Nothing else — there are no module dependencies beyond Drupal core, and no third‑party
  Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/unpublished_404 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/unpublished_404 -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en unpublished_404 -y
```

That's the entire setup. There are no submodules, no settings page, and no configuration.
The 403 → 404 behaviour is active immediately and applies site‑wide.

## Verify it worked

Log out (or switch to a role that lacks the *view own unpublished content* permission) and
visit the URL of an unpublished node. You should get a **404 Not Found** page rather than a
403 "Access denied".
