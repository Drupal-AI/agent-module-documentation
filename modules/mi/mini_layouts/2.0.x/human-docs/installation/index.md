# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Layout Builder** module enabled — this is the module's dependency, and
  Drupal will enable it (and its own dependencies, Layout Discovery and Block)
  automatically. Mini Layouts stores and edits its sections using Layout Builder.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/mini_layouts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mini_layouts -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mini_layouts -y
```

Drupal enables **Layout Builder** as a dependency if it isn't already on. You can
now create your first reusable section at **Structure → Mini Layouts** — see
[Configuration](../configuration/index.md).

## Permission

The module adds one permission, **Administer mini layouts**, which governs listing,
adding, editing, and deleting mini layouts as well as access to their Layout
Builder canvas. Grant it to trusted roles at **People → Permissions**.
