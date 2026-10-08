# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Serialization** module (`serialization`) — Drupal enables it
  automatically as a dependency when you turn on API Toolkit.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/api_toolkit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/api_toolkit -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en api_toolkit -y
```

## Examples submodule

API Toolkit ships one optional submodule, **API Toolkit Examples**
(`api_toolkit_examples`), which registers sample endpoints so you can see how the
framework is meant to be used:

```bash
drush en api_toolkit_examples -y
```

Enable it while you learn the pattern, then disable it on production sites where
you do not want the example routes exposed.
