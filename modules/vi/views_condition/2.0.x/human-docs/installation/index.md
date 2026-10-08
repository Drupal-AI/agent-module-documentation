# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core's **Views** module (`views`), which ships with Drupal and is enabled
  automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_condition -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_condition -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_condition -y
```

That's all. There is nothing to configure at the module level — the new **Views
Condition** visibility option appears immediately on the block layout form and
anywhere else Drupal evaluates conditions. See
[How to use it](../index.md#how-to-use-it) in the overview.
