# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- No other contributed modules are required — it builds on core's Field and
  entity-reference systems. You will, of course, need an entity-reference field
  to apply the formatter to.

## Install with Composer

From the project root:

```bash
composer require drupal/random_reference_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/random_reference_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en random_reference_formatter -y
```

## Verify it worked

Go to the **Manage display** screen of an entity that has an entity-reference
field. In the format dropdown for that field, **Random Rendered entity** should
now be available. Select it, set a count, save, and reload a page that shows the
field — you should see a random selection of the referenced items that changes
between requests.
