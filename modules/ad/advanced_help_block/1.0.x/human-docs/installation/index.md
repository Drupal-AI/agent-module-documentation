# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Contributed modules **Field Group** (`field_group`), **Libraries**
  (`libraries`), and **Data Layer** (`datalayer`).
- Core **Text** (`text`), **Options** (`options`), **User** (`user`), and **Help**
  (`help`).

> **Note the `datalayer` dependency.** Data Layer is a tracking-adjacent module.
> Its presence in a help feature is a side effect of this module coming from the
> YMCA Website Services distribution — worth being aware of before you install
> this on a site that is not part of that distribution.

## Install with Composer

From the project root:

```bash
composer require drupal/advanced_help_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed and pull in the contributed dependencies above.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/advanced_help_block -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_help_block -y
```

Drupal will enable the dependencies (Field Group, Libraries, Data Layer, and the
core modules) at the same time. After enabling, assign the view/add/edit
permissions and create your first help block — see
[Configuration](../configuration/index.md).
