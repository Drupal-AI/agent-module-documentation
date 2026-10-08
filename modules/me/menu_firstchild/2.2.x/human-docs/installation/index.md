# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Menu Link Content** module (`menu_link_content`) — Drupal enables it
  automatically as a dependency. The module acts on `menu_link_content` links, so
  the links you flag must be custom menu links (the kind you add by hand), not
  links defined in code.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_firstchild -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_firstchild -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_firstchild -y
```

There is no configuration to do afterwards. Enabling the module adds the **First
child** checkbox to the menu‑link add/edit form — see [How to use
it](../index.md#how-to-use-it) in the overview.

## Submodules

Menu Firstchild ships no submodules.
