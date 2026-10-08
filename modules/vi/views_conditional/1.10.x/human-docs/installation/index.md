# Installation

## Requirements

Views Conditional is lightweight. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled — this is the only dependency, and it
  is part of Drupal core.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_conditional -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_conditional -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_conditional -y
```

Make sure the core **Views** and **Views UI** modules are on so you can build
views. There is no required configuration and no settings form of its own.

## Submodules

Views Conditional ships **no submodules**.

## Verify it worked

Edit any view, open its **Fields** section, and click **Add**. You should see
**Views: Views Conditional** in the list under the *Views* group. Adding it and
saving is enough to confirm the module is active.
