# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no other module dependencies and no third‑party PHP library requirements.

> **Do not enable Extra Field alongside efs.** The maintainers warn that running
> `efs` together with the [Extra Field](https://www.drupal.org/project/extra_field)
> module can cause unexpected behaviour. Choose one.

## Install with Composer

From the project root:

```bash
composer require drupal/efs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/efs -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en efs -y
```

## Verify it worked

There is no UI of its own to check. Confirm the module is enabled (`drush pml |
grep efs`), then implement an extra-field plugin in a module of your own — it should
be placeable on the target entity's **Manage display** and **Manage form display**,
each instance with its own settings.
