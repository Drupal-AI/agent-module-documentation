# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- No third‑party Composer or PHP library requirements, and no other module
  dependencies — it builds only on Drupal core's local‑task system.

## Install with Composer

From the project root:

```bash
composer require drupal/local_tasks_more -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/local_tasks_more -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en local_tasks_more -y
```

## Verify it worked

Log in as an editor or administrator and open any content (node) page. The local
task tabs at the top should now show only the everyday links (View, Edit, and so
on) with a **Show more** toggle revealing the rest, and the node **Delete** tab
hidden by default. Click the toggle to expand and collapse the extra tabs.
