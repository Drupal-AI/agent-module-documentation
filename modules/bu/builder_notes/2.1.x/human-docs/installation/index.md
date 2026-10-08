# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field UI** module (`field_ui`), which Drupal enables automatically as
  a dependency — it is what provides the field and display config forms the notes
  attach to.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/builder_notes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/builder_notes -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en builder_notes -y
```

That is all it takes. Open any supported config-entity edit form and you will
find the **Builder Notes** textarea in its additional settings — see
[How to use it](../index.md#how-to-use-it).
