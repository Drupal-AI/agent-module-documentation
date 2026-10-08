# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies and no third-party PHP libraries. (You'll use core's
  Field UI to add the field, which is part of a standard Drupal install.)

## Install with Composer

From the project root:

```bash
composer require drupal/contact_info_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/contact_info_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contact_info_field -y
```

## Verify it worked

Go to any content type's **Manage fields** page and click **Add field**. The
**Contact Info** field type should appear in the list of available field types.
Add one to confirm you can configure its elements and display (see "How to use it"
in the [overview](../index.md)).
