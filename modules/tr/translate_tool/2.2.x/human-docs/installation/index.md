# Installation

## Requirements

- **Drupal 8 through 12** (`core_version_requirement: ^8 || ^9 || ^10 || ^11 || ^12`).
- **PHP 7.1** or newer.
- Core's **Locale** module (`locale`) enabled — this is the only dependency, and it
  provides the interface‑translation storage the helper wraps. Drupal enables it
  automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/translate_tool -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/translate_tool -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en translate_tool -y
```

There are no submodules and nothing to configure. Once enabled, the `translate_tool`
service and the `translate_tool_add()` / `translate_tool_delete()` functions are
available to your code — see the [overview](../index.md#how-to-use-it) for usage.
