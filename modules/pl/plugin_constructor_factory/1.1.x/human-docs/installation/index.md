# Installation

## Requirements

- **Drupal 8.8.4, 9, 10, or 11** (`core_version_requirement: ^8.8.4 || ^9.0 ||
  ^10.0 || ^11`).
- **PHP 7.2 or newer**.
- No other Drupal module dependencies, and no third‑party Composer library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/plugin_constructor_factory -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/plugin_constructor_factory -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en plugin_constructor_factory -y
```

Remember that enabling the module has no visible effect on its own — it only makes
the `ConstructorFactory` classes available for your code to opt into.

## Submodules — optional

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Plugin Constructor Factory Core** | `plugin_constructor_factory_core` | Constructor‑injectable base classes and managers for core plugin types — Action, Filter, and QueueWorker — plus a service provider, so you can adopt constructor injection for those types without writing the plumbing yourself. |

Enable it with:

```bash
drush en plugin_constructor_factory_core -y
```

## Verify it worked

This module has no user‑facing page. Once `drush pm:list` shows it as **Enabled**,
its factory classes and traits are available to import in your own modules. The
real confirmation is in code: opt a plugin manager in, inject a dependency through
a plugin's constructor, and see the plugin instantiate correctly.
