# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies and no third-party library requirements — the
  project's own docs list requirements as "None."

## Install with Composer

From the project root:

```bash
composer require drupal/entity_field_fetch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_field_fetch -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_field_fetch -y
```

## Verify it worked

There is no admin settings page. To confirm the module is active, edit any content
type under **Structure → Content types → (type) → Manage fields → Add field** and
check that **Entity Field Fetch field** appears in the field-type list. From there,
follow the "How to use it" steps in the parent [guide](../index.md).
