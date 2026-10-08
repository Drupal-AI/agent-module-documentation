# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **[Token](https://www.drupal.org/project/token)** module (`drupal/token ^1.0`).
  Composer pulls this in automatically with the command below.
- Core's **Node**, **Menu Link Content**, **System**, and **User** modules, which
  are standard on a normal Drupal site and are enabled automatically as dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/add_child_page -W
```

This installs Add Child Page together with its Token dependency. The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/add_child_page -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en add_child_page -y
```

Or enable **Add Child Page** from *Extend* (`/admin/modules`). Drupal will enable the
Token module at the same time if it isn't already on.

There are no submodules. After enabling, open
**Configuration → Content authoring → Add Child Page** to choose which content types
use the feature and where the links appear, then grant the **Access add child page**
permission — see [How to use it](../index.md#how-to-use-it).
