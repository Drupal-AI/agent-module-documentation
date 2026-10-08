# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Datetime** (`datetime`) and **Datetime Range** (`datetime_range`)
  modules — these are dependencies and Drupal enables them automatically.

There are no extra PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/optional_end_month_year_range -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/optional_end_month_year_range -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en optional_end_month_year_range -y
```

Enabling the module also enables core's Datetime and Datetime Range modules if they
are not already on.

## Verify it worked

Log in as an administrator and go to any bundle's **Manage fields** (for example
**Structure → Content types → *(a type)* → Manage fields**). When you add a new
field, **Optional End Month Year Range** should appear in the list of available field
types. See the [main guide](../index.md) for how to set up the widget, formatter, and
the "No end date" checkbox.
