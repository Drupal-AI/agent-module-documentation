# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10||^11`, and the release
  is tested through core 12).

There are no third‑party Composer or PHP library requirements, and no other module
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonprettyprint -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonprettyprint -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonprettyprint -y
```

## Verify it worked

Go to the **Manage display** tab of an entity that has a string or long-text field
holding JSON (for example a content type under **Structure → Content types →
*(your type)* → Manage display**). The **JSON Pretty Print** option should now be
available in that field's **Format** selector. Set it, save, and view an entity to
confirm the JSON renders indented.
