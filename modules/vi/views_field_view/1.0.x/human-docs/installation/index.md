# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled — Drupal enables it automatically as a
  dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_field_view -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_field_view -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_field_view -y
```

Once enabled, the **Global: View** field is available whenever you add a field to a
view. There is no settings form and there are no submodules — see
[How to use it](../index.md#how-to-use-it).

> **Note on recursion:** the module carries a single hidden setting, `evil`
> (default off), which normally blocks a view from embedding itself. Leave it off
> unless you have a specific, controlled need for recursive embedding.
