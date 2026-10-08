# Installation

## Requirements

- **Drupal 10.1 or newer, or Drupal 11** (`core_version_requirement:
  ^10.1 || ^11`).
- **PHP 8.1 or newer**.
- Core's **Views** module (`views`) enabled — this is the only dependency, and
  Drupal enables it automatically as a dependency when you turn on Views Field
  Compare.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_field_compare -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_field_compare -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_field_compare -y
```

That's all it takes. The two new filters — **Field comparison** and **Field
contained** — now appear under the **Global** category whenever you add a filter
criterion in the Views UI. There is no configuration form; see the
[overview](../index.md#how-to-use-it) for how to add them to a view.
