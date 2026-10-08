# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **CKEditor 5** (`ckeditor5`) and **Filter** (`filter`) modules — both are
  part of a standard Drupal install and provide the editor and text-format
  machinery this module plugs into.

There are no third-party PHP library requirements, no permissions of its own, and
no Drush commands. The module has no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_readmore -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_readmore -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_readmore -y
```

## Next steps

There is no global configuration. Everything is set up per text format — head to
the [overview](../index.md) and follow **How to use it** to add the Read more
button and enable the Filter readmore filter on a format. Remember: both steps are
required for the feature to work end to end.
