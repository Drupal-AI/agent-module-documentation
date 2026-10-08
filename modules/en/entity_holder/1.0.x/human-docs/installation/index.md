# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Filter** module (`filter`) — used to render the fallback content's
  formatted text. Drupal enables it automatically as a dependency, and it is on by
  default on most sites.

There are no third‑party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_holder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_holder -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_holder -y
```

## Verify it worked

Log in as an administrator and go to **Structure → Entity holders**
(`/admin/structure/entity-holder`). You should see the (initially empty) holder
collection with a link to add your first holder. From there, continue to
[Configuration](../configuration/index.md).
