# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **Node** module (`node`) and **Menu Link Content** module
  (`menu_link_content`) — both enabled automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/node_type_defaults -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_type_defaults -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_type_defaults -y
```

## Verify it worked

Go to **Structure → Content types**, edit a content type, and confirm the extra
default options (preview mode, available menus, author/date display) are present. Set
them, save, then start creating a node of that type — its form should open with the
defaults you configured.
