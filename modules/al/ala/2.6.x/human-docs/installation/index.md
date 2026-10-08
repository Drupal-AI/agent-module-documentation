# Installation

## Requirements

Advanced Link Attributes needs:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Link** module (`link`), which Drupal enables automatically as a
  dependency. The whole module is built on top of core Link fields, so you'll
  also want at least one Link field somewhere to attach it to.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ala -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ala -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ala -y
```

Enabling the module makes the **Advanced Link Attributes** widget and formatter
available; you still choose them per field on the *Manage form display* and
*Manage display* tabs (see the [main guide](../index.md)). If you want a shared,
site‑wide class list first, set it up in
[Configuration](../configuration/index.md).
