# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The contrib **[Context](https://www.drupal.org/project/context)** module
  (`context`) — this is a hard dependency. Composer pulls it in automatically,
  and Drupal enables it when you turn on Context Entity Field.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/context_entity_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including the Context module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/context_entity_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en context_entity_field -y
```

This also enables the Context module if it is not already on. There is no
configuration form to visit and no permissions to grant — the new **Entity
Field** condition is immediately available inside the Context UI at
**Structure → Context**.

## Verify it worked

Go to **Structure → Context** (`/admin/structure/context`), edit or add a
context, and open the **Conditions** picker. You should see an *Entity Field*
condition for each bundled entity type (Content, Taxonomy term, Media, and so
on). If it appears, the module is working.
