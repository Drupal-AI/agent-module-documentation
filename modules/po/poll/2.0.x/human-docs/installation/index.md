# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Several core modules, which Drupal enables automatically as dependencies:
  **Field** (`field`), **Node** (`node`), **Options** (`options`),
  **Views** (`views`), and **User** (`user`).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/poll -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Because the current release is an alpha,** Composer may refuse to install it
> unless your project's `minimum-stability` allows it. If you hit that, either
> lower `minimum-stability` in `composer.json` or require the specific version,
> e.g. `composer require drupal/poll:^2.0@alpha -W`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/poll -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en poll -y
```

Or from the UI, enable **Poll** on the **Extend** page (`/admin/modules`).

## Optional submodule

Poll ships one submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Poll Devel** | `poll_devel` | A Devel Generate plugin for bulk‑creating sample polls when testing. Requires the [Devel](https://www.drupal.org/project/devel) module (`drupal/devel ^5.3`). Do not enable it on a production site. |

Enable it only when you need test data:

```bash
drush en poll_devel -y
```

Next, grant permissions and create your first poll — see
[Configuration](../configuration/index.md).
