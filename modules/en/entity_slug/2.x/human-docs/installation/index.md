# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The contributed **Pathauto** (`pathauto`) module, which supplies the
  string‑cleaning used to build tidy slugs.

There are no PHP library requirements. Composer will pull in Pathauto with the
`-W` flag below.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_slug -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update
dependencies such as Pathauto.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_slug -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_slug -y
```

Make sure Pathauto is enabled too:

```bash
drush en pathauto -y
```

## Verify it worked

Go to a bundle's **Manage fields** screen and **Add field** — the **Slug** and
**Slug Path** field types should appear as choices. See the "How to use it" section
of the [overview](../index.md) for adding and configuring the field.
