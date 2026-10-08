# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No third-party Composer or PHP library requirements are declared.
- To attach models to entities via a reference field, you also enable the bundled
  `access_conditions_entity` submodule (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/access_conditions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/access_conditions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en access_conditions -y
```

To also get the access-model **reference field** (its own field type, widget, and
formatter) for attaching models to entities, enable the submodule:

```bash
drush en access_conditions_entity -y
```

Related submodules pair the checker with other systems — for example
`access_conditions_field_group` for field-group visibility and
`access_conditions_commerce` for checkout-pane visibility — enable whichever your
site needs.

## Set the permissions

Under **People → Permissions**:

- **`administer access models`** — grant to trusted site builders only; it
  controls who can create and edit the visibility rules.
- **`bypass access conditions access`** — grant to roles that should ignore all
  models (their evaluation short-circuits to "allowed"). Treat this as a
  privileged permission.

Next, create your first model — see [Configuration](../configuration/index.md).
