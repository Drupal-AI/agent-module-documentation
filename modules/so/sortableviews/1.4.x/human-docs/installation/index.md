# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).
- Core's **Views** module (`views`), enabled automatically as a dependency.
- A spare **integer field** on whichever entity type you want to reorder — this is
  where the order is stored. You create this as a normal field; the module does not
  add it for you.

There are no third‑party libraries, no settings page, and no permissions of its
own.

## Install with Composer

From the project root:

```bash
composer require drupal/sortableviews -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sortableviews -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sortableviews -y
```

There are no submodules. Once enabled, the three sortable Views formats, the
drag‑handle field, and the Save area become available when you edit a View — see
[How to use it](../index.md#how-to-use-it).
