# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).
- No other module dependencies and no third-party libraries. It builds on core's
  Field API, so you'll use core's Field UI to add the field.

## Install with Composer

From the project root:

```bash
composer require drupal/headline_group -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/headline_group -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en headline_group -y
```

## Verify it worked

Go to a content type's **Manage fields → Add field** page — **Structure →
Content types → *(your type)* → Manage fields → Add field**. The **Headline
Group** field type should appear in the list. Add it, then check the field
settings and **Manage display** to configure the parts and output, as described
in [How to use it](../index.md#how-to-use-it).
