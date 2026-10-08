# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **User** (`user`) and **Filter** (`filter`) modules, both of which are
  part of a standard Drupal install and are enabled automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_abuse -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_abuse -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_abuse -y
```

## Verify it worked

After enabling, go to **Structure → Entity abuse**
(`/admin/structure/entity-abuse`). If the settings form loads, the module is
installed. Note that nothing changes on your site's front end yet — the "Add
complaint" link only appears once you choose the content types that can be reported
and grant the relevant permissions. See [Configuration](../configuration/index.md)
for those next steps.
