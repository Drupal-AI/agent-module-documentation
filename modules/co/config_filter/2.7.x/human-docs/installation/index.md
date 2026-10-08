# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement:
  ^8.8 || ^9 || ^10 || ^11`). It relies on core's config storage transformation
  API, which was introduced in 8.8.
- **No module dependencies**, no third‑party PHP libraries, and no minimum PHP
  version of its own beyond what your Drupal core requires.

Configuration Filter is often installed automatically as a dependency of another
module (such as **Configuration Split**), in which case Composer and Drupal
handle it for you and you can skip the steps below.

## Install with Composer

From the project root:

```bash
composer require drupal/config_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/config_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_filter -y
```

That's all. There is **nothing to configure** — no settings form, no
permissions, no submodules. The module simply makes the `ConfigFilter` plugin
type and filtered sync storage available to any module that provides filters.
Its effect only appears once you install a module that supplies filters (for
example **Configuration Split**) or write your own — see the
[overview](../index.md#how-to-use-it).
