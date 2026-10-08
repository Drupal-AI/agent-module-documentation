# Installation

## Requirements

Read More Extra Field (1.x) is deliberately tiny. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), which is part of a standard install and is
  pulled in automatically as a dependency.

There are no third‑party Composer packages or PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/readmore_extrafield -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/readmore_extrafield -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en readmore_extrafield -y
```

## Verify it worked

Go to any content type's **Manage display** (for example **Structure → Content
types → Article → Manage display**) and switch to the **Teaser** view mode. In
the **Extra fields** area you should now see a **Read more** row that you can drag
into position or disable. See the [main guide](../index.md#how-to-use-it) for the
step‑by‑step.
