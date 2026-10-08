# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Bootstrap-based theme**, since the widget uses the framework's dropdown
  component for its styling.
- The **Bootstrap Multiselect JavaScript library**. Check the module's own
  `README` for whether it bundles the library or expects you to add it to your
  `libraries/` directory, and follow that guidance for your version.

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap_multiselect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bootstrap_multiselect -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bootstrap_multiselect -y
```

After enabling, choose the multiselect widget on the fields where you want it —
see [How to use it](../index.md#how-to-use-it) in the overview. There is no
settings form.
