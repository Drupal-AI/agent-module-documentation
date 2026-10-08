# Installation

## Requirements

- **Drupal 11.4 or newer, or Drupal 12** (`core_version_requirement:
  ^11.4 || ^12`). Note this 2.0.x branch targets recent Drupal only — check your
  core version before installing.
- Core's **Field** module (`field`), which every standard Drupal site already has
  enabled.

There are no third-party Composer packages and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/field_formatter_range -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/field_formatter_range -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_formatter_range -y
```

There is no configuration step and no settings page. As soon as the module is
enabled, the extra **Field Formatter Range** controls appear on the *Manage
display* page for multi-value fields.

## Verify it worked

Go to a bundle that has a **multi-value** field — for example
`/admin/structure/types/manage/article/display` — and click the cog on that
field's row. You should see a **Field Formatter Range** section with *Order*,
*Display items* and *Skip items* controls. If the section isn't there, confirm the
field's cardinality is greater than 1 (the controls only show on multi-value
fields).

For how to use the controls, see the "How to use it" section on the
[overview page](../index.md).
