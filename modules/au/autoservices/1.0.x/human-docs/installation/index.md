# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third‑party module, Composer, or PHP library requirements.

> **It does nothing on its own.** Autoservices only has an effect when another
> module adopts its convention (a class in `src/Autoservice/`). Install it as a
> **dependency** of the module that will use it, rather than as a standalone feature.

## Install with Composer

From the project root:

```bash
composer require drupal/autoservices -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/autoservices -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autoservices -y
```

The module ships no submodules and has no configuration. Once enabled, any module
that places classes in `src/Autoservice/` gets them registered as autowired
services — see [How to use it](../index.md#how-to-use-it).
