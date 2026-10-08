# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** (`field`) module — the only dependency, present in a standard
  Drupal install.
- No external PHP libraries. (The live embed relies on CodePen's own embed script
  loaded in the visitor's browser at view time.)

## Install with Composer

From the project root:

```bash
composer require drupal/codepen -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/codepen -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en codepen -y
```

## Verify it worked

Go to a content type at **Structure → Content types → *(type)* → Manage fields →
Add field** and confirm that **Codepen Embed** appears as an available field
type. See [Configuration](../configuration/index.md) for adding and configuring
the field, and for the site-wide defaults page.
