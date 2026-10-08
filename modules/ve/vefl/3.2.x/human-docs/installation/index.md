# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** (`views`) and **Layout Discovery** (`layout_discovery`)
  modules. These are required dependencies and Drupal enables them automatically
  when you turn on VEFL.

Optionally, the **Better Exposed Filters** module (`better_exposed_filters`) if
you want to lay out BEF forms — see the submodule note below.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/vefl -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/vefl -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en vefl -y
```

Enabling VEFL also enables core's Views and Layout Discovery modules if they are
not already on.

## Submodule — Better Exposed Filters support

VEFL ships one optional submodule, **VEFL for Better Exposed Filters**
(`vefl_bef`), which brings the same region‑placement capability to forms built
with the Better Exposed Filters module. Enable it only if you use BEF:

```bash
drush en vefl_bef -y
```

It requires the `better_exposed_filters` module to be installed.

## Verify it worked

Edit a View that has exposed filters (**Structure → Views**). In the **Exposed
form** section you should now be able to set the **Exposed form style** to **Basic
(with layout)**. Once applied, its settings let you pick a layout and place each
widget in a region.
