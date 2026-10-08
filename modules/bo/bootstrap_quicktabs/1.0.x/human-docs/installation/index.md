# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11**
  (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **Quicktabs** module (`quicktabs`) — this is a hard dependency; the
  Bootstrap renderers plug into it.
- A **Bootstrap‑based theme** (Bootstrap 3 markup) that provides the tab and
  collapse JavaScript and CSS. This isn't a Composer dependency, but the
  renderers assume it is present to actually make the tabs work.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap_quicktabs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Quicktabs and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bootstrap_quicktabs -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bootstrap_quicktabs -y
```

Drupal enables Quicktabs at the same time if it isn't already on. The two
Bootstrap renderers then become available when you build a Quicktabs instance —
see [Configuration](../configuration/index.md).

## Submodules

None — Bootstrap Quicktabs ships as a single module.
