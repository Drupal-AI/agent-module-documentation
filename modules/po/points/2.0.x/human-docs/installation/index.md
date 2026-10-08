# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`). Note this release
  does not declare Drupal 11 support — check the project page for a newer release
  if you are on Drupal 11.
- Core's **Field** (`field`) module and the contrib **Inline Entity Form**
  (`inline_entity_form`) module — both are pulled in as dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/points -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Inline Entity
Form dependency and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/points -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en points -y
```

Enabling the module creates a **default** point type and a `points` field as part
of its install configuration, so you have something to work with immediately.

## Verify it worked

Log in as an administrator and visit **`admin/structure/points`**. You should be
able to administer point entities and point types there. Confirm the **default**
point type exists, then continue to [Configuration](../configuration/index.md) to
create point types and attach points to other entities.
