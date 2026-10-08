# Installation

## Requirements

- **Drupal 8.7.7, 9, 10, or 11** (`core_version_requirement: ^8.7.7 || ^9 || ^10 || ^11`).
- **PHP 7.1** or newer.
- No module dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_rewrite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_rewrite -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_rewrite -y
```

Configuration Rewrite has no settings page and ships no submodules. It only does its
work when a module that contains a `config/rewrite/` directory is installed — so the
next step is to add rewrite YAML to one of your own modules, as described in
[How to use it](../index.md#how-to-use-it) on the overview page.

> **Tip:** keep `config_rewrite` enabled for as long as the modules that depend on its
> rewrite behavior are installed.
