# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** (`views`) and **Field** (`field`) modules enabled — both are
  standard on most sites and are pulled in as dependencies.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_field_select_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_field_select_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_field_select_filter -y
```

There is nothing to configure at install time. Every string and integer field
immediately gains a **"(selector)"** filter option in the Views UI — see the
[overview](../index.md#how-to-use-it) for how to add and expose it.
