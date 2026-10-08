# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11 || ^12`).
- No other modules, PHP extensions, or third-party libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/themespace -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If another module (such as Transmuter) pulls Themespace in
as a dependency, Composer will normally add it for you when you require that module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/themespace -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en themespace -y
```

Enabling it produces no visible change — that is expected. Themespace is a developer
API with no configuration and no admin UI; it simply makes theme namespaces and
provider-typed plugin discovery available to any module or theme that uses them.
