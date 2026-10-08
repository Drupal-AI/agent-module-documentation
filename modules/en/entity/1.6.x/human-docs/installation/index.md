# Installation

## Requirements

Entity is a pure developer framework with no dependencies:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- No other contrib modules and no third‑party PHP libraries are required.

You will often not install this by hand at all — modules such as Drupal Commerce
and Profile declare it as a dependency and Composer brings it in for you.

## Install with Composer

From the project root:

```bash
composer require drupal/entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity -y
```

That's all there is to it. Enabling the module makes its handlers, route
providers, base classes, and services available to your custom entity types —
there is no configuration step and no settings page.

There are **no submodules**.
