# Installation

## Requirements

Examples for Developers needs:

- **Drupal 10.6 or 11** (`core_version_requirement: ^10.6 || ^11.0`).
- Core's **Toolbar** module (`toolbar`), used for the Examples tray — Drupal
  enables it automatically as a dependency.

There are no third‑party Composer or PHP library requirements. Individual example
submodules may depend on other core modules, which Drupal will enable as you turn
each one on.

## Install with Composer

From the project root:

```bash
composer require drupal/examples -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/examples -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the parent module to get the Examples toolbar tray:

```bash
drush en examples -y
```

Then enable only the specific example submodule you want to study — for instance
the Form API tutorial:

```bash
drush en form_api_example -y
```

Each example is self‑contained; enable and uninstall them independently. See the
[main guide](../index.md#the-example-submodules) for the full list of submodules
and what each one teaches.

> **Reminder:** these are learning modules. Enable the one you're studying, read
> its code and tests, then uninstall it — they are not intended to remain enabled
> on production sites.
