# Installation

## Requirements

Helper Class is deliberately lightweight and has no third‑party dependencies:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no Composer library or PHP extension requirements. It works well
alongside the **Field Group** and **Field Formatter Class** modules if you already
use them.

## Install with Composer

From the project root:

```bash
composer require drupal/helper_class -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/helper_class -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

> **Note:** At the time of writing, Helper Class is published as an alpha release.
> Test it on a non‑production environment before relying on it.

## Enable the module

```bash
drush en helper_class -y
```

## Verify it worked

Go to a View or an entity display, add a helper class to a row, wrapper, or entity,
and save. Reload the front‑end page and inspect the element in your browser's
developer tools — the class you entered should appear in the markup. That confirms
the module is working.
