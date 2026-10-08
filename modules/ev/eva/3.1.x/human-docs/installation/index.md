# Installation

## Requirements

- **Drupal 9.5.11, 10, or 11** (`core_version_requirement: ^9.5.11 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled — this is EVA's only hard dependency,
  and Drupal enables it automatically as a dependency when you turn on EVA.
- *Optional:* the [Token](https://www.drupal.org/project/token) module
  (`drupal/token`) adds a token browser to EVA's arguments form. Not required.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/eva -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eva -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

If you want the optional token browser, also require Token:

```bash
composer require drupal/token -W
```

## Enable the module

```bash
drush en eva -y
```

That's all. The new **EVA** display type is now available when you edit a View — see
[How to use it](../index.md#how-to-use-it) to attach a View to an entity.

There are no submodules.
