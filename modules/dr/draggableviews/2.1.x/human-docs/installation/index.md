# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module (`views`), which Drupal enables automatically as a
  dependency (it is part of the standard install).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/draggableviews -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/draggableviews -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en draggableviews -y
```

Enabling the module makes the **Draggableviews: Content** field and
**Draggableviews: Weight** sort available inside Views. Nothing on your site
changes until you add them to a view — see
[How to use it](../index.md#how-to-use-it) on the overview page.

## Grant the permission

Ordering is gated by the **Access Draggableviews** (`access draggableviews`)
permission. Give it to the roles that should be allowed to re-order and save, at
**People → Permissions**, or with Drush:

```bash
drush role:perm:add editor 'access draggableviews'
```

## Optional: the demo submodule

DraggableViews ships an optional **DraggableViews Demo**
(`draggableviews_demo`) submodule with example views that show a working
setup. Enable it if you want something to learn from, then disable it on a
production site:

```bash
drush en draggableviews_demo -y
```
