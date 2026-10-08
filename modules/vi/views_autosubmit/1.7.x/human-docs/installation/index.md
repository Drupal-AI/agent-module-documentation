# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled — part of core and normally already on.
  Drupal enables it automatically as a dependency if not.

There are no third-party Composer or PHP library requirements. The module relies on
core JavaScript libraries (jQuery, `core/once`, `core/drupal`) it bundles its own
behavior on top of.

## Install with Composer

From the project root:

```bash
composer require drupal/views_autosubmit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_autosubmit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_autosubmit -y
```

That makes the **Autosubmit** exposed-form style available in the Views editor. No
submodules ship with this project.

## Next step

Enabling the module changes nothing on its own — you select the Autosubmit style
per view display. See the "How to use it" section on the [overview page](../index.md)
for the walkthrough.
