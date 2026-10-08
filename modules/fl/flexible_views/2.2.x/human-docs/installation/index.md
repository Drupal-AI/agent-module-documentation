# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`) enabled — this is the only dependency, and
  it's on by default on most sites.

There are no third‑party Composer or PHP library requirements. The
`views_field_permissions` module is an optional integration (if present, its
access‑hidden fields are excluded from the column selector), not a requirement.

## Install with Composer

From the project root:

```bash
composer require drupal/flexible_views -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/flexible_views -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flexible_views -y
```

There is no settings form and no permissions to grant. Enabling the module simply
makes the three Views plugins — the **Flexible Table** style, the **Visible Column
Selector** filter, and the **Manual selection** exposed form — available in the
Views UI. See [the main page](../index.md#how-to-set-it-up) for how to wire them
together on a view.
