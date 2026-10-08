# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Views** (which is enabled on virtually every site).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_dependent_filters -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/views_dependent_filters -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_dependent_filters -y
```

## A note on the bundled submodule

The project also contains a submodule named **`views_dependent_filter`** (singular).
It is a **deprecated compatibility shim** that only exists to migrate sites from the
old Drupal 8 module name. **Do not enable it on new sites** — just enable
`views_dependent_filters` (plural) as above.

## Next step

There is nothing to configure globally. The "Global: Dependent filter" handler is now
available to add inside any view. See [How to use it](../index.md#how-to-use-it).
